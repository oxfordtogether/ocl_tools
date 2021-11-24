module OclTools
  module Process
    module Attributes
      extend ActiveSupport::Concern

      ALLOWED_TYPES = %i[string]

      class_methods do
        def attribute(name, type: :string)
          if !ALLOWED_TYPES.include?(type)
            raise AttributeError.new(
              "Type #{type.inspect} is not supported. Choose one of: #{ALLOWED_TYPES.map(&:inspect).join(', ')}"
            )
          end

          attr_reader name

          define_method("#{name}=") do |value|
            case type
            when :string
              instance_variable_set("@#{name}", value)
            when :integer
            when :date
            end
          end
        end
      end
    end
  end
end
