module OclTools
  class TableComponent < ViewComponent::Base
    delegate :group_category_badge, to: :helpers

    def initialize(collection, row_url: nil, small: false, show_header: true, &blk)
      @collection = collection
      @row_url = row_url
      @cols = []
      @small = small
      @show_header = show_header

      yield self if blk
    end

    def col(name, width = '', classes: '', &blk)
      @cols << Column.new(name, width, classes, self, blk)
    end

    def call_block(*args, &blk)
      view_context.capture(*args, &blk)
    end

    attr_reader :cols, :collection, :row_url, :show_header
  end

  Column = Struct.new(:name, :width, :classes, :table_component, :blk) do
    def contents(*args)
      table_component.call_block(*args, &blk)
    end
  end
end
