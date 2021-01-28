module OclTools
  class DateFieldComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(form:, method:, value: nil, errors: false)
      @form = form
      @method = method
      @value = value
      @errors = errors

      classes = "shadow-sm focus:ring-indigo-500 focus:border-indigo-500 inline w-full sm:text-sm border-gray-300 rounded-md".freeze
      error_classes = "shadow-sm block w-full sm:text-sm rounded-md border-red-300 text-red-900 placeholder-red-900 focus:outline-none focus:ring-red-500 focus:border-red-500".freeze

      @classes = errors ? error_classes : classes
    end

    attr_reader :form, :method
  end
end
