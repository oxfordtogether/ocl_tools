module OclTools
  class AutocompleteComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(label:, field_id:, field_name:, value_method: :id, text_method: :name, search_params:, disabled: false, object: nil, results: nil, list_item_component: nil, error: false)
      @results = results || search_params[:results]
      @object = object
      @label = label
      @field_id = field_id
      @field_name = field_name
      @value_method = value_method
      @text_method = text_method
      @search_params = search_params
      @disabled = disabled
      @list_item_component = list_item_component
      @error = error
    end

    def signed_params
      params = {
        label: label,
        field_id: field_id,
        field_name: field_name,
        value_method: value_method,
        text_method: text_method,
        search_params: search_params,
        disabled: disabled,
        list_item_component: list_item_component,
      }
      Rails.application.message_verifier(:autocomplete).generate(params)
    end

    def has_custom_list_item_component?
      !!list_item_component
    end

    attr_reader :results, :label, :field_id, :field_name, :value_method, :text_method, :search_params, :disabled, :object, :list_item_component
  end
end
