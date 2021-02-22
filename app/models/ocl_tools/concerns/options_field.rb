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

      # get the field to always return a symbol
      define_method(name) { attributes[name.to_s]&.to_sym }
      define_method("humanized_#{name}") { options[send(name)] }
    end
  end
end
