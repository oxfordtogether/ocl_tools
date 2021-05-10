module OclTools
  class MultipleSelectComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(method, collection, initial_selected_options, id, name, errors: false)
      @method = method
      @collection = collection

      @id = id
      @name = name

      @errors = errors

      @initial_selected_options = @collection
            .filter { |c| initial_selected_options.map(&:to_s).include?(c[1].to_s) }
            .map { |c| [c[0].to_s, c[1].to_s] }
    end
  end
end
