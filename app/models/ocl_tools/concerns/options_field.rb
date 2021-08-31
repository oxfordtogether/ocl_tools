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
        def better_options_field(name, prefix: true, &blk)
          builder = OptionsBuilder.new
          builder.instance_eval(&blk)

          # we're going to lean on rails' enum helper for most of this
          converted_definitions = { name => builder.all_options.map {|o| [o.id, o.description]}.to_h }
          converted_definitions[:_prefix] = prefix if prefix
          enum converted_definitions

          # rails' select will accept arrays like [["Some description", :some_option], ..]
          define_singleton_method("#{name}_options_for_select") { builder.options.map { |o| [o.description, o.id] } }
          define_singleton_method("#{name}_all_options_for_select") { builder.all_options.map { |o| [o.description, o.id] } }
          define_singleton_method("humanized_#{name}") { |val| builder.find(val)&.name }
          define_singleton_method("#{name}_options") { builder.all_options }

          # get the field to always return a symbol
          define_method(name) { attributes[name.to_s]&.to_sym }
          define_method("humanized_#{name}") { builder.find(send(name))&.description }
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
