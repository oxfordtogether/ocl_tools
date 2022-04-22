module OclTools
  module RadioGroupSelect
    def radio_group_select(label, value)
      find('label', text: label.to_s).find(:xpath, '../../../..').choose(value.to_s)
    end
  end
end
