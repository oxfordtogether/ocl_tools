module OclTools
  module TimeSelect
    def time_select(hour, min, from:)
      container = find(:label, text: from).find(:xpath, "../../../..")

      id_prefix = container.find("label")[:for]
      select hour, from: "#{id_prefix}_4i"
      select min, from: "#{id_prefix}_5i"
    end
  end
end
