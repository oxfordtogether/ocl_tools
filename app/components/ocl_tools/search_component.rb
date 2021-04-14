module OclTools
  class SearchComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    attr_reader :results, :search_result_blk

    def initialize(results, status, &blk)
      @results = results
      @status = status

      yield self if blk
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
