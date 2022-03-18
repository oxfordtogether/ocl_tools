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

      ALLOWED_TYPES = %i[string integer date datetime time boolean rich_text array].freeze

      class_methods do
        def attribute_names
          @attribute_names ||= []
        end

        def attribute(name, type: :string, custom_type: nil, default: nil, &blk)
          raise AttributesError, type if custom_type.nil? && !ALLOWED_TYPES.include?(type)

          attr_writer name

          define_method(name) do
            instance_variable_get("@#{name}") || default
          end

          if type == :array
            array_class = Class.new do
              include Attributes
              class_eval(&blk) if blk
            end
            default ||= []

            define_method("push_#{name}_attributes") do |index, attrs|
              send(name).insert(index, array_class.new.tap { |c| c.assign_attributes(attrs) })
            end
          end

          attribute_names.push(name)

          define_method("extract_#{name}") do |params|
            params ||= {}

            if custom_type
              return unless params.key?(name)

              val = params[name]
              return send("#{name}=", val.is_a?(custom_type) ? val : custom_type.from_param(val))
            end

            case type
            when :string
              send("#{name}=", params[name]) if params.key?(name)
            when :integer
              send("#{name}=", params[name]&.to_i) if params.key?(name)
            when :boolean
              send("#{name}=", ActiveModel::Type::Boolean.new.cast(params[name])) if params.key?(name)
            when :rich_text
              send("#{name}=", ActionText::RichText.new(body: params[name])) if params.key?(name)
            when :array
              return unless params.key?(name)
              if params[name].is_a?(Array)
                send("#{name}=", params[name].map { |x| array_class.new.tap { |c| c.assign_attributes(x) } }) if params.key?(name)
              elsif params[name].is_a?(ActionController::Parameters)
                # we'll get {"0" => {...}, "1" => {...}} back from the frontend
                send("#{name}=", params[name].values.map { |x| array_class.new.tap { |c| c.assign_attributes(x) } }) if params.key?(name)
              else
                raise "Unexpected type for array attributes: #{params[name].inspect}"
              end
            when :date
              if params.key?(name)
                val = params[name]
                val = nil unless val.present?
                return send("#{name}=", val)
              end

              year_key = "#{name}(1i)"
              month_key = "#{name}(2i)"
              day_key = "#{name}(3i)"

              if [year_key, month_key, day_key].all? { |k| params.key?(k) }
                # NOTE: nil.to_i == "".to_i == 0
                year = params[year_key]&.to_i
                month = params[month_key]&.to_i
                day = params[day_key]&.to_i

                begin
                  date = Date.new(year, month, day)
                rescue Date::Error
                  # NOTE: if part of date is missing, this will clear others
                  date = nil
                end

                send("#{name}=", date)
              end
            when :datetime
              # NOTE: we don't do any checks on type here
              return send("#{name}=", params[name]) if params.key?(name)

              year_key = "#{name}(1i)"
              month_key = "#{name}(2i)"
              day_key = "#{name}(3i)"
              hour_key = "#{name}(4i)"
              minute_key = "#{name}(5i)"

              if [year_key, month_key, day_key, hour_key, minute_key].all? { |k| params.key?(k) }
                # NOTE: nil.to_i == "".to_i == 0
                year = params[year_key]&.to_i
                month = params[month_key]&.to_i
                day = params[day_key]&.to_i
                hour = params[hour_key]&.to_i
                minute = params[minute_key]&.to_i

                begin
                  datetime = Time.zone.local(year, month, day, hour, minute)
                rescue ArgumentError
                  # NOTE: if part of date is missing, this will clear others
                  datetime = nil
                end

                send("#{name}=", datetime)
              end
            when :time
              # re-implements :datetime without any reference to year/month/day
              # NOTE: we don't do any checks on type here
              return send("#{name}=", params[name]) if params.key?(name)

              hour_key = "#{name}(4i)"
              minute_key = "#{name}(5i)"

              if [hour_key, minute_key].all? { |k| params.key?(k) }
                # NOTE: nil.to_i == "".to_i == 0
                hour = params[hour_key]&.to_i
                minute = params[minute_key]&.to_i

                begin
                  datetime = Time.zone.local(1970, 1, 1, hour, minute)
                rescue ArgumentError
                  # NOTE: if part of date is missing, this will clear others
                  datetime = nil
                end

                send("#{name}=", datetime)
              end
            end
          end
        end
      end

      # map keys allows us to change the names of some attributes
      def attributes(map_keys: {})
        self.class.attribute_names.map { |a| [map_keys[a] || a, send(a)] }.to_h
      end

      def assign_attributes(params = {})
        # TODO: we should probably split this into extract_attributes (which converts from params),
        # and assign_attributes (which expects to get full-blooded objects)
        self.class.attribute_names.each do |a|
          send("extract_#{a}", params)
        end
      end
    end
  end
end
