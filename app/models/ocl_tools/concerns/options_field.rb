module OclTools
  module Concerns
    module OptionsField
      extend ActiveSupport::Concern

      module ClassMethods
        # options_field :a, {b: "B desc", c: "C", d: "D"}, prefix: true
        #
        # is equivalent to
        #
        # enum a: { b: 'b', c: 'c', d: 'd'}, _prefix: true
        #
        # and will also add the methods
        #
        # - MyClass.a_options_for_select
        # - my_object.humanized_a

        def options_field(name, options, prefix: true)
          # we're going to lean on rails' enum helper for most of this
          converted_definitions = { name => options.map { |k, _v| [k, k.to_s] }.to_h }
          converted_definitions[:_prefix] = prefix if prefix
          enum converted_definitions

          # rails' select will accept arrays like [["Some description", :some_option], ..]
          define_singleton_method("#{name}_options_for_select") { options.map { |k, v| [v, k] } }
          define_singleton_method("humanized_#{name}") { |val| options[val] }

          # get the field to always return a symbol
          define_method(name) { attributes[name.to_s]&.to_sym }
          define_method("humanized_#{name}") { options[send(name)] }
        end

        # better_options_field :contact_method do
        #   option :in_person_home, "Home visit"
        #   option :in_person_not_home, "In person (not at home)"
        #   archived_option :in_person, "In person"
        # end
        def better_options_field(name, prefix: true, options: nil, &blk)
          builder = options || OptionsBuilder.new

          #  we don't want to execute the block on another model's builder, as that will change its options too
          raise "Can't provide both options and a block" if options && block_given?

          builder.instance_eval(&blk) if block_given?

          # we're going to lean on rails' enum helper for most of this
          converted_definitions = { name => builder.all_options.map { |o| [o.id, o.id.to_s] }.to_h }
          converted_definitions[:_prefix] = prefix if prefix
          enum converted_definitions

          # rails' select will accept arrays like [["Some description", :some_option], ..]
          define_singleton_method("#{name}_options_for_select") { builder.options.map { |o| [o.label, o.id] } }
          define_singleton_method("#{name}_all_options_for_select") { builder.all_options.map { |o| [o.label, o.id] } }
          define_singleton_method("humanized_#{name}") { |val| builder.find(val)&.label }
          define_singleton_method("#{name}_option") { |val| builder.find(val) }
          define_singleton_method("#{name}_options") { builder }
          define_singleton_method("all_#{name}_options") { builder.all_options }

          # get the field to always return a symbol
          define_method(name) { attributes[name.to_s]&.to_sym }
          define_method("humanized_#{name}") { builder.find(send(name))&.label }
          define_method("#{name}_option") { builder.find(send(name)) }
        end

        def better_options_group(name, prefix: false, options: nil, &blk)
          plural_name = name.to_s.pluralize
          singular_name = name.to_s.singularize
          builder = options || OptionsBuilder.new

          #  we don't want to execute the block on another model's builder, as that will change its options too
          raise "Can't provide both options and a block" if options && block_given?

          builder.instance_eval(&blk) if block_given?

          define_singleton_method("all_#{singular_name}_options") { builder.all_options }
          define_singleton_method("#{singular_name}_options") { builder }
          define_singleton_method("#{singular_name}_option") { |val| builder.find(val) }

          define_method("has_#{singular_name}?") do |opt_or_id|
            id = opt_or_id.is_a?(Option) ? opt_or_id.id : opt_or_id
            !!send(prefix ? "#{singular_name}_#{id}" : id)
          end
          define_method(plural_name) { builder.all_options.select { |x| send(prefix ? "#{singular_name}_#{x.id}" : x.id) } }
          define_method("#{singular_name}_ids") { send(plural_name).map(&:id) }
          define_method("humanized_#{plural_name}") { send(plural_name).map(&:label) }
        end
      end

      class Option
        attr_reader :id, :description, :colour, :label

        def initialize(id, label = nil, archived: false, final: false, colour: nil, description: nil)
          raise ArgmentError, "option's id must be a symbol" unless id.is_a?(Symbol)

          @id = id
          @label = label || id.to_s.humanize
          @description = description || @label
          @final = final
          @archived = archived
          @colour = colour.nil? ? BadgeColour.default : BadgeColour.check(colour)
        end

        def archived?
          archived
        end

        def final?
          final
        end
      end

      class OptionsBuilder
        include Enumerable

        attr_accessor :options, :archived_options

        def initialize
          @options = []
          @archived_options = []
        end

        def find(id)
          all_options.find { |x| x.id.to_s == id.to_s }
        end

        def each(&block)
          options.each(&block)
        end

        def sample
          options.sample
        end

        def all_options
          @options + @archived_options
        end

        def option(id, label = nil, final: false, colour: nil, description: nil)
          @options << Option.new(id, label, final: final, colour: colour, description: description)
        end

        def archived_option(id, label = nil, final: false, colour: nil, description: nil)
          @archived_options << Option.new(id, label, final: final, colour: colour, archived: true, description: description)
        end
      end
    end
  end
end
