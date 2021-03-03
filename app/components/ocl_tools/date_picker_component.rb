module OclTools
  class DatePickerComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(ids:, names:, placeholder:, value: nil, disabled: false, start_year: nil, end_year: nil, options: {}, errors: false)
      @ids = ids
      @names = names
      @value = value
      @disabled = disabled

      @days_of_week = %w[Sun Mon Tue Wed Thu Fri Sat]
      @months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]

      @options = options.keys.map { |k| "#{k}=#{options[k]}" }.join(" ")
      @placeholder = placeholder

      @start_year = start_year || 1910
      @end_year = end_year || 2050
    end
  end
end
