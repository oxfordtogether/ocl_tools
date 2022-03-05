module OclTools
  class TableComponent < ViewComponent::Base
    delegate :group_category_badge, to: :helpers

    def initialize(collection, sort_prefix: nil, sort_default: nil, sort_url: nil, row_url: nil, small: false, show_header: true, &blk)
      @collection = collection
      @sort_prefix = sort_prefix
      @sort_default = sort_default
      @sort_url = sort_url
      @sort_column_param = sort_prefix ? sort_prefix + "_" + :sort_column : :sort_column
      @sort_direction_param = :sort_direction
      @row_url = row_url
      @cols = []
      @small = small
      @show_header = show_header

      yield self if blk
    end

    def before_render
      @sort_column = view_context.params[@sort_column_param]
      @sort_direction = view_context.params[@sort_direction_param]

      col = @cols.find{|col| col.sortable.to_s == @sort_column}
      
      if col
        @collection = @collection.sort_by(&col.sortable)
        if col.is_sorted(:descending)
           @collection = @collection.reverse
        end
      elsif @sort_default
        @collection = @collection.sort_by(&@sort_default)
      end
    end

    def sort_url(sort_params)
      @sort_url.kind_of?(Array) ? 
          view_context.send(*@sort_url, sort_params) :
          view_context.send(@sort_url, sort_params)
    end

    def col(name, width = "", classes: "", sortable: nil, &blk)
      @cols << Column.new(name, width, classes, sortable, self, blk)
    end

    def call_block(*args, &blk)
      view_context.capture(*args, &blk)
    end

    attr_reader :cols, :collection, :sort_column, :sort_direction, :sort_column_param, :sort_direction_param, :row_url, :show_header
  end

  Column = Struct.new(:name, :width, :classes, :sortable, :table_component, :blk) do
    def contents(*args)
      table_component.call_block(*args, &blk)
    end

    def sort_url
      sort_params = is_sorted(:descending) ? {} : {
        table_component.sort_column_param => sortable,
        table_component.sort_direction_param => is_sorted(:ascending) ? :descending : :ascending,
      }
      
      table_component.sort_url(sort_params)
    end

    def is_sorted(direction = nil)
      table_component.sort_column == sortable.to_s && (direction == nil || table_component.sort_direction == direction.to_s)
    end

  end
end
