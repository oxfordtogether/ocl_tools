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

    def before_render
      @sort_column = view_context.params[:sort_column]
      @sort_direction = view_context.params[:sort_direction]
    end

    def col(name, width = '', classes: '', sortable: nil, &blk)
      @cols << Column.new(name, width, classes, sortable, self, blk)
    end

    def call_block(*args, &blk)
      view_context.capture(*args, &blk)
    end

    def sort_url(sort_params)
      url_for(request.query_parameters.merge(sort_params))
    end

    attr_reader :cols, :collection, :row_url, :show_header, :sort_column, :sort_direction
  end

  Column = Struct.new(:name, :width, :classes, :sortable, :table_component, :blk) do
    def contents(*args)
      table_component.call_block(*args, &blk)
    end

    def is_sorted(direction = nil)
      table_component.sort_column == sortable.to_s && (direction == nil || table_component.sort_direction == direction.to_s)
    end

    def sort_url
      sort_params = is_sorted() ? {
        sort_column: sortable,
        sort_direction: is_sorted(:ascending) ? :descending : :ascending,
        page: nil
      } : {
        sort_column: sortable,
        sort_direction: :ascending,
        page: nil
      }

      table_component.sort_url(sort_params)
    end
  end
end
