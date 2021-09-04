# replacement for date_field_fill_in
module OclTools
  module FillInDate
    def fill_in_date(name, with:)
      label = find(:label, text: name)
      id_prefix = label['for']

      fill_in "#{id_prefix}(3i)", with: with.day
      fill_in "#{id_prefix}(2i)", with: with.month
      fill_in "#{id_prefix}(1i)", with: with.year
    end
  end
end
