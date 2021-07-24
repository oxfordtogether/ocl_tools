module OclTools
  module AutocompleteSelect
    def autocomplete_select(name, from:)
      raise "Name too short to be found by autocomplete: #{name}" if name.length < 3

      container = find(:label, text: from).find(:xpath, "../..")

      # fill in the query
      container.find('input[data-autocomplete-target="query"]').set(name[0..3])

      # select the result
      container.find("li", text: name).click
    end
  end
end
