module OclTools
  class DatePickerComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(ids:, names:, placeholder:, value: nil, start_year: nil, end_year: nil, options: {}, errors: false)
      @ids = ids
      @names = names
      @value = value

      @days_of_week = %w[Sun Mon Tue Wed Thu Fri Sat]
      @months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]

      @options = options.keys.map { |k| "#{k}=#{options[k]}" }.join(" ")
      @placeholder = placeholder

      @start_year = start_year || 1910
      @end_year = end_year || 2050

      classes = "shadow-sm focus:ring-indigo-500 focus:border-indigo-500 inline w-full sm:text-sm border-gray-300 rounded-md".freeze
      error_classes = "shadow-sm block w-full sm:text-sm rounded-md border-red-300 text-red-900 placeholder-red-900 focus:outline-none focus:ring-red-500 focus:border-red-500".freeze

      @classes = errors ? error_classes : classes
    end
  end
end
