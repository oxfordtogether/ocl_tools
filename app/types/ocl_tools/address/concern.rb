module OclTools
  module Address
    module Concern
      extend ActiveSupport::Concern

      class_methods do
        def has_address(name)
          define_method(name) do
            a = Type.new(
              line_1: send("#{name}_line_1"),
              line_2: send("#{name}_line_2"),
              line_3: send("#{name}_line_3"),
              city: send("#{name}_city"),
              postcode: send("#{name}_postcode")
            )
            a.empty? ? nil : a
          end

          define_method("#{name}=") do |val|
            send("#{name}_line_1=", val.try(:line_1))
            send("#{name}_line_2=", val.try(:line_2))
            send("#{name}_line_3=", val.try(:line_3))
            send("#{name}_city=", val.try(:city))
            send("#{name}_postcode=", val.try(:postcode))
          end

          define_method("normalize_#{name}_postcode") do
            send("#{name}_postcode=", Helpers.normalize_postcode(send("#{name}_postcode")))
          end

          before_validation "normalize_#{name}_postcode".to_sym
        end
      end
    end
  end
end
