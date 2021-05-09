module OclTools
  class MultipleSelectComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(method, collection, initial_selected_options, id, name, errors: false)
      @method = method
      @collection = collection

      @id = id
      @name = name

      @errors = errors

      @initial_selected_options = initial_selected_options
    end
  end
end
