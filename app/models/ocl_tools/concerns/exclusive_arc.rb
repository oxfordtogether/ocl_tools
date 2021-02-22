module OclTools
  module Concerns
    module ExclusiveArc
      extend ActiveSupport::Concern

      module ClassMethods
        def has_exclusive(name, from:)
          relationships = from

          define_method("#{name}_id") do
            relationships.each do |relationship|
              key = self.class.reflect_on_association(relationship).foreign_key
              id = send(key)
              return Utils.to_disambiguated_id(relationship, id) if id
            end
            return nil
          end

          define_method("#{name}_id=") do |disambiguated_id|
            if disambiguated_id.present?
              target_relationship, id = Utils.from_disambiguated_id(disambiguated_id)
            else
              target_relationship = nil
              id = nil
            end

            relationships.each do |relationship|
              key = self.class.reflect_on_association(relationship).foreign_key
              send("#{key}=", target_relationship == relationship ? id : nil)
            end
          end

          define_method("#{name}_type") do
            disambiguated_id = send("#{name}_id")
            return nil unless disambiguated_id.present?

            relationship, _id = Utils.from_disambiguated_id(disambiguated_id)
            relationship
          end

          define_method(name.to_s) do
            relationship = send("#{name}_type")
            return nil unless relationship

            send(relationship)
          end

          define_singleton_method("for_#{name}_id") do |disambiguated_id|
            return nil unless disambiguated_id.present?

            relationship, id = ExclusiveArc::Utils.from_disambiguated_id(disambiguated_id)
            foreign_key = reflect_on_association(relationship).foreign_key
            where(foreign_key => id)
          end

          define_singleton_method("find_by_#{name}_id") do |disambiguated_id|
            send("for_#{name}_id", disambiguated_id).first
          end
        end

        def is_exclusive_option_for(name, as: nil)
          define_method("#{name}_type") do
            as || self.class.model_name.singular.to_sym
          end
          define_method("#{name}_id") do
            Utils.to_disambiguated_id(send("#{name}_type"), id)
          end
        end
      end

      module Utils
        def self.to_disambiguated_id(relationship, id)
          "#{relationship}__#{id}"
        end

        def self.from_disambiguated_id(disambiguated_id)
          relationship, id = disambiguated_id.split("__")
          [relationship.to_sym, id.to_i]
        end
      end
    end
  end
end
