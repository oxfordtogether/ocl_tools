module OclTools
  class TableComponent < ViewComponent::Base
    delegate :group_category_badge, to: :helpers

    def initialize(collection, row_url: nil, &blk)
      @collection = collection
      @row_url = row_url
      @cols = []

      yield self if blk
    end

    def col(name, width = "", &blk)
      @cols << Column.new(name, width, self, blk)
    end

    def call_block(*args, &blk)
      view_context.capture(*args, &blk)
    end

    attr_reader :cols, :collection, :row_url
  end

  Column = Struct.new(:name, :width, :table_component, :blk) do
    def contents(*args)
      table_component.call_block(*args, &blk)
    end
  end
end
