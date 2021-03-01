module OclTools
  class PageProgressComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(progress_items)
      @progress_items = progress_items
    end
  end
end
