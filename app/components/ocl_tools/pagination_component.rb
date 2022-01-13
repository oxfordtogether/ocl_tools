module OclTools
  class PaginationComponent < ViewComponent::Base
    include Pagy::Frontend
    delegate :icon, to: :helpers

    attr_reader :no_padding

    def initialize(pagy:, things:, no_padding: false)
      @pagy = pagy
      @things = things
      @no_padding = no_padding
    end
  end
end
