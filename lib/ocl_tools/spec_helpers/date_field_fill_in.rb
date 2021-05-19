module OclTools
  module DateFieldFillIn
    def date_field_fill_in(model, field, date)
      fill_in "#{model}_#{field}(3i)", with: date.day
      fill_in "#{model}_#{field}(2i)", with: date.month
      fill_in "#{model}_#{field}(1i)", with: date.year
    end
  end
end
