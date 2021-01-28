module OclTools
  class NoticeComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(notice:)
      @notice = notice
    end
  end
end
