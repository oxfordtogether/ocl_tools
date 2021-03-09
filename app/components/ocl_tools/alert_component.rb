module OclTools
  class AlertComponent < ViewComponent::Base
    delegate :icon, to: :helpers
    with_content_areas :title, :info

    def initialize; end
  end
end
