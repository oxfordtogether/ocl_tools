module OclTools
  class SearchComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    attr_reader :results, :search_result_blk, :class_name, :search_params

    def initialize(results, status, class_name: nil, search_params: {}, &blk)
      @results = results
      @status = status
      @class_name = class_name
      @search_params = search_params

      yield self if blk
    end

    def stringified_search_params
      search_params && JSON.generate(search_params)
    end

    def search_result(&blk)
      @search_result_blk = SearchResult.new(self, blk)
    end

    def call_block(*args, &blk)
      view_context.capture(*args, &blk)
    end

    SearchResult = Struct.new(:search_component, :blk) do
      def contents(*args)
        search_component.call_block(*args, &blk)
      end
    end
  end
end
