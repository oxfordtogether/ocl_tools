module OclTools
  class BlockAlertComponent < ViewComponent::Base
    delegate :icon, to: :helpers
    renders_one :title
    renders_one :info

    def initialize; end
  end
end
