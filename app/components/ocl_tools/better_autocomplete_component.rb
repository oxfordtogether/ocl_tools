module OclTools
  class AutocompleteComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(label:, field_id:, field_name:, value_method: :id, text_method: :name, reflex:, disabled: false, object: nil, results: nil, list_item_component: nil, error: false)
      @results = results
      @object = object
      @label = label
      @field_id = field_id
      @field_name = field_name
      @value_method = value_method
      @text_method = text_method
      @reflex = reflex
      @disabled = disabled
      @list_item_component = list_item_component
      @error = error
    end

    def has_custom_list_item_component?
      !!list_item_component
    end

    attr_reader :results, :label, :field_id, :field_name, :value_method, :text_method, :reflex, :disabled, :object, :list_item_component
  end
end
