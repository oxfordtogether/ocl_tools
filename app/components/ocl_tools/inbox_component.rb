module OclTools
  class InboxComponent < ViewComponent::Base
    include Pagy::Frontend
    delegate :icon, to: :helpers

    def initialize(pagy:, things:)
      @pagy = pagy
      @things = things
    end
  end
end
