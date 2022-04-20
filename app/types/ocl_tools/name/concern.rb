module OclTools
  module Name
    module Concern
      extend ActiveSupport::Concern

      class_methods do
        def has_name(property_name, include_preferred: false, include_title: false)
          raise "Name fields must end in 'name'" unless property_name.to_s[-4..-1] == 'name'

          prefix = property_name.to_s.split('name').first

          define_method(property_name) do
            a = Type.new(
              first_name: send("#{prefix}first_name"),
              last_name: send("#{prefix}last_name"),
              preferred_name: include_preferred ? send("#{prefix}preferred_name") : nil,
              title: include_title ? send("#{prefix}title") : nil
            )
            a.empty? ? nil : a
          end

          define_singleton_method("include_preferred_#{property_name}?") do
            include_preferred
          end

          define_method("has_#{prefix}preferred_name") do
            !!send(property_name)&.has_preferred?
          end

          define_method("#{property_name}=") do |val|
            send("#{prefix}first_name=", val.try(:first_name))
            send("#{prefix}last_name=", val.try(:last_name))
            send("#{prefix}preferred_name=", val.try(:preferred_name)) if include_preferred
            send("#{prefix}title=", val.try(:first_name)) if include_title
          end
        end
      end
    end
  end
end
