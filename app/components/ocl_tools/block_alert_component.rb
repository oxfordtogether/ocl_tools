module OclTools
  class BlockAlertComponent < ViewComponent::Base
    delegate :icon, to: :helpers
    with_content_areas :title, :info

    def initialize; end
  end
end
