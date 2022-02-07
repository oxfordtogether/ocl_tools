module OclTools
  module RadioGroupSelect
    def radio_group_select(label, value)

      find('label', text: label).find(:xpath, '../..').choose(value)
    end
  end
end
