module OclTools
  module FillInDatetime
    include DatePickerSelect
    include FillInDate

    def fill_in_datetime(name, with:, autocomplete: true)
      if autocomplete
        date_picker_select(with, from: name)
      else
        fill_in_date(name, with: with)
      end

      label = find(:label, text: name)
      id_prefix = label['for']

      select with.hour.to_s.rjust(2, '0'), from: "#{id_prefix}_4i"
      select with.min.to_s.rjust(2, '0'), from: "#{id_prefix}_5i"
    end
  end
end
