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
        def better_options_field(name, prefix: true, &blk)
          builder = OptionsBuilder.new
          builder.instance_eval(&blk)
          instance_variable = "@#{name}"

          # rails' select will accept arrays like [["Some description", :some_option], ..]
          define_singleton_method("#{name}_options_for_select") { builder.options.map { |o| [o.description, o.id] } }
          define_singleton_method("#{name}_all_options_for_select") { builder.all_options.map { |o| [o.description, o.id] } }
          define_singleton_method("humanized_#{name}") { |val| builder.find(val)&.description }
          define_singleton_method("#{name}_options") { builder.all_options }

          define_method("#{name}_options_for_select") { builder.options.map { |o| [o.description, o.id] } }
          define_method("#{name}_all_options_for_select") { builder.all_options.map { |o| [o.description, o.id] } }
          define_method("#{name}_options") { builder.all_options }

          define_method(name) { instance_variable_get(instance_variable) }
          define_method("#{name}=") do |val|
            if builder.options.map(&:id).map(&:to_s).include?(val.to_s)
              instance_variable_set(instance_variable, val.to_sym)
            else
              raise ArgumentError.new("#{val.inspect} is not a valid option for #{name}")
            end
          end
          define_method("humanized_#{name}") { builder.find(send(name))&.description }

          builder.options.each do |option|
            option_name = prefix ? "#{name}_#{option.id}" : option.id
            define_method("#{option_name}?") { send(name) == option.id }
          end
        end

        class Option < Struct.new(:id, :description, :archived)
          def archived?
            archived
          end
        end

        class OptionsBuilder
          attr_accessor :options, :archived_options
          def initialize
            @options = []
            @archived_options = []
          end

          def find(id)
            all_options.find { |x| x.id.to_s == id.to_s }
          end

          def all_options
            @options + @archived_options
          end

          def option(id, name = nil)
            raise "first argument of option must be a symbol" unless id.is_a?(Symbol)
            @options << Option.new(id, name || id.to_s.humanize, false)
          end

          def archived_option(id, name = nil)
            raise "first argument of archived_option must be a symbol" unless id.is_a?(Symbol)
            @archived_options << Option.new(id, name || id.to_s.humanize, true)
          end
        end
      end
    end
  end
end
