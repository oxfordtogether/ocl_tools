module OclTools
  module FillInRichText
    def fill_in_rich_text(name, with:)
      label = find(:label, text: name)
      id = label['for']
      container = label.find(:xpath, '../../../..')
      box = container.find('trix-editor', id: id)

      box.click.set(with)
    end
  end
end
