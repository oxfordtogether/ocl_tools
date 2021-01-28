module OclTools
  class PaginationComponent < ViewComponent::Base
    include Pagy::Frontend
    delegate :icon, to: :helpers

    def initialize(pagy:)
      @pagy = pagy

      # set of boxes to display in component
      # if more than 10 pages, will show something like: 1 ... 4 5 6 7 8 ... 20
      @boxes = if @pagy.last <= 10
                (0..10).to_a
              elsif @pagy.page <= 6
                (2..8).to_a
              elsif @pagy.page >= @pagy.last - 5
                ((@pagy.last - 7)..(@pagy.last - 1)).to_a
              else
                ((@pagy.page - 3)..(@pagy.page + 3)).to_a
              end
    end
  end
end
