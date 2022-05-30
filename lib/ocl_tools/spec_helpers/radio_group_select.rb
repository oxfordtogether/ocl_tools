module OclTools
  module RadioGroupSelect
    def radio_group_select(label, value)
      find('label', text: label.to_s).find(:xpath, '../../../..').choose(value.to_s)
    end

    def description_radio_group_select(label, value)
      find('legend', text: label.to_s).find(:xpath, '..').find('label', text: value.to_s).find(:xpath, '../..').choose
    end
  end
end
