module OclTools
  module DatePickerSelect
    def date_picker_select(date, from:)
      container = find(:label, text: from).find(:xpath, "../..")

      container.find("input").click
      container.find("#date-picker__change-year").click
      find("#date-picker__year-#{date.year}").click
      find("#date-picker__month-#{date.strftime('%b')}").click
      find("#date-picker__day-#{date.day}").click
    end
  end
end
