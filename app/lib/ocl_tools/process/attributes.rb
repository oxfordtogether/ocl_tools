module OclTools
  module Process
    module Attributes
      class AttributesError < ArgumentError
        def initialize(type)
          @type = type
        end
    
        def message
          "Type #{@type.inspect} is not supported. Choose one of: #{Attributes::ALLOWED_TYPES.map(&:inspect).join(', ')}"
        end
      end

      extend ActiveSupport::Concern
      include ActiveModel::Model # for validations?
      include OclTools::Actions::OptionsField
      include ActiveRecord::AttributeAssignment

      ALLOWED_TYPES = %i[string integer date]


      class_methods do
        def attribute_names
          @attribute_names ||= []
        end

        def attribute(name, type: :string)
          raise AttributesError.new(type) if !ALLOWED_TYPES.include?(type)

          attr_accessor name

          attribute_names.push(name)

          define_method("extract_#{name}") do |params|
            params ||= {}
            case type
            when :string
              self.send("#{name}=", params[name]) if params.has_key?(name)
            when :integer
              self.send("#{name}=", params[name]&.to_i) if params.has_key?(name)
            when :date
              # note: we don't do any checks on type here
              return self.send("#{name}=", params[name]) if params.has_key?(name)

              year_key = "#{name}(1i)"
              month_key = "#{name}(2i)"
              day_key = "#{name}(3i)"

              if [year_key, month_key, day_key].all? {|k| params.has_key?(k)}
                # note: nil.to_i == "".to_i == 0
                year = params[year_key]&.to_i
                month = params[month_key]&.to_i
                day = params[day_key]&.to_i

                begin
                  date = Date.new(year, month, day)
                rescue Date::Error
                  # note: if part of date is missing, this will clear others
                  date = nil
                end

                self.send("#{name}=", date)
              end
            end
          end
        end
      end

      def attributes 
        self.class.attribute_names.map {|a| [a, send(a)]}.to_h
      end

      def assign_attributes(params = {})
        self.class.attribute_names.each do |a|
          send("extract_#{a}", params) 
        end
      end
    end
  end
end
