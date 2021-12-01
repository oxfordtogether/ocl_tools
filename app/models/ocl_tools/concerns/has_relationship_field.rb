module OclTools
  module Concerns
    module HasRelationshipField
      extend ActiveSupport::Concern

      class_methods do
        def has_relationship_field(field_name)
          better_options_field field_name do
            option :husband, "Husband"
            option :wife, "Wife"
            option :partner, "Partner"
            option :friend, "Friend"
            option :son, "Son"
            option :daughter, "Daughter"
            option :son_in_law, "Son-in-law"
            option :daughter_in_law, "Daughter-in-law"
            option :grandson, "Grandson"
            option :granddaughter, "Granddaughter"
            option :professional_carer, "Professional carer"
            option :other, "Other"
          end

          define_method("inverse_#{field_name}") do |gender = nil|
            gender = :default unless %i[male female].include?(gender)

            case field_name
            when :husband
              { male: :husband, female: :wife, default: :wife }[gender]
            when :wife
              { male: :husband, female: :wife, default: :husband }[gender]
            when :partner
              :partner
            when :friend
              :friend
            when :son, :daughter
              { male: :father, female: :mother, default: :parent }[gender]
            when :son_in_law, :daughter_in_law
              { male: :father_in_law, female: :mother_in_law, default: :parent_in_law }[gender]
            when :grandson, :granddaughter
              { male: :grandfather, female: :grandmother, default: :grandparent }[gender]
            when :professional_carer
              :client
            end
          end
          define_method("humanized_inverse_#{field_name}") do |gender = nil|
            send("inverse_#{field_name}", gender)&.to_s&.humanize&.downcase
          end
        end
      end
    end
  end
end
