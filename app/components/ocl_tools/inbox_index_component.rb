module OclTools
  class InboxIndexComponent < ViewComponent::Base
    include Pagy::Frontend
    delegate :icon, to: :helpers
    renders_one :body
    renders_one :left_aligned_actions

    def initialize(pagy:, items:)
      @pagy = pagy
      @items = items
    end

    attr_reader :pagy, :items
  end
end
