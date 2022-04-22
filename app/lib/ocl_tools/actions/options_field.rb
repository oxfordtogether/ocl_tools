module OclTools
  module Actions
    # The same as OclTools::Concerns::OptionsField, but for non-active-record objects
    module OptionsField
      extend ActiveSupport::Concern

      module ClassMethods
        # better_options_field :contact_method do
        #   option :in_person_home, "Home visit"
        #   option :in_person_not_home, "In person (not at home)"
        #   archived_option :in_person, "In person"
        # end
        def better_options_field(name, prefix: true, options: nil, &blk)
          builder = options || OclTools::Concerns::OptionsField::OptionsBuilder.new

          #  we don't want to execute the block on another model's builder, as that will change its options too
          raise "Can't provide both options and a block" if options && block_given?

          builder.instance_eval(&blk) if block_given?
          instance_variable = "@#{name}"

          # rails' select will accept arrays like [["Some description", :some_option], ..]
          define_singleton_method("#{name}_options_for_select") { builder.options.map { |o| [o.description, o.id] } }
          define_singleton_method("#{name}_all_options_for_select") { builder.all_options.map { |o| [o.description, o.id] } }
          define_singleton_method("humanized_#{name}") { |val| builder.find(val)&.description }
          define_singleton_method("#{name}_option") { |val| builder.find(val) }
          define_singleton_method("#{name}_options") { builder }
          define_singleton_method("all_#{name}_options") { builder.all_options }

          define_method("#{name}_options_for_select") { builder.options.map { |o| [o.description, o.id] } }
          define_method("#{name}_all_options_for_select") { builder.all_options.map { |o| [o.description, o.id] } }
          define_method("#{name}_options") { builder }
          define_method("all_#{name}_options") { builder.all_options }

          define_method(name) { instance_variable_get(instance_variable) }
          define_method("#{name}=") do |val|
            if builder.options.map(&:id).map(&:to_s).include?(val.to_s)
              instance_variable_set(instance_variable, val.to_sym)
            elsif val.blank?
              instance_variable_set(instance_variable, nil)
            else
              raise ArgumentError, "#{val.inspect} is not a valid option for #{name}"
            end
          end
          define_method("humanized_#{name}") { builder.find(send(name))&.description }

          builder.options.each do |option|
            option_name = prefix ? "#{name}_#{option.id}" : option.id
            define_method("#{option_name}?") { send(name) == option.id }
          end
        end

        def better_options_group(name, prefix: false, options: nil, &blk)
          plural_name = name.to_s.pluralize
          singular_name = name.to_s.singularize
          builder = options || OclTools::Concerns::OptionsField::OptionsBuilder.new

          #  we don't want to execute the block on another model's builder, as that will change its options too
          raise "Can't provide both options and a block" if options && block_given?

          builder.instance_eval(&blk) if block_given?

          define_singleton_method("all_#{singular_name}_options") { builder.all_options }
          define_singleton_method("#{singular_name}_options") { builder }
          define_singleton_method("#{singular_name}_option") { |val| builder.find(val) }

          define_method("has_#{singular_name}?") do |opt_or_id|
            id = opt_or_id.is_a?(OclTools::Concerns::OptionsField::Option) ? opt_or_id.id : opt_or_id
            !!send(id)
          end
          define_method(plural_name) { builder.all_options.select { |x| send(prefix ? "#{singular_name}_#{x.id}" : x.id) } }
          define_method("#{singular_name}_ids") { send(plural_name).map(&:id) }
          define_method("humanized_#{plural_name}") { send(plural_name).map(&:label) }

          builder.options.each do |option|
            option_name = prefix ? "#{singular_name}_#{option.id}" : option.id

            attr_accessor option_name

            define_method("#{option_name}?") { send(option_name) }
          end
        end
      end
    end
  end
end
