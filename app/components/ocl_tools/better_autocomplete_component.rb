module OclTools
  class BetterAutocompleteComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(label:, field_id:, field_name:, reflex:, value_method: :id, text_method: :name, disabled: false, object: nil, results: nil, list_item_component: nil, error: false, on_select: nil)
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
      @on_select = on_select
      @error = error
    end

    def has_custom_list_item_component?
      !!list_item_component
    end

    attr_reader :results, :label, :field_id, :field_name, :value_method, :text_method, :reflex, :disabled, :object, :list_item_component
  end
end
