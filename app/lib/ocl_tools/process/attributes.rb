module OclTools
  module Process
    module Attributes
      extend ActiveSupport::Concern

      ALLOWED_TYPES = %i[string date]

      class_methods do
        def attribute_names
          @attribute_names ||= []
        end

        def attribute(name, type: :string)
          if !ALLOWED_TYPES.include?(type)
            raise AttributeError.new(
              "Type #{type.inspect} is not supported. Choose one of: #{ALLOWED_TYPES.map(&:inspect).join(', ')}"
            )
          end

          attr_reader name

          attribute_names.push(name)

          define_method("#{name}=") do |value|
            case type
            when :string
              instance_variable_set("@#{name}", value)
            when :integer
            when :date
              date_or_string = value
              # ActiveRecord::AttributeAssignment will pass through a hash of the form:
              # "{3=>8, 2=>9, 1=>2022}"
              # There must be a better way than this...
              if date_or_string.is_a?(String)
                m = /\{3=>(\d+), 2=>(\d+), 1=>(\d+)\}/.match(date_or_string)
                raise "Error parsing date: #{date_or_string}" unless m
      
                date = Date.new(m[3].to_i, m[2].to_i, m[1].to_i)
              else
                date = date_or_string
              end
              instance_variable_set("@#{name}", date)
            end
          end
        end
      end

      def attributes 
        self.class.attribute_names.map {|a| [a, send(a)]}.to_h
      end
    end
  end
end
