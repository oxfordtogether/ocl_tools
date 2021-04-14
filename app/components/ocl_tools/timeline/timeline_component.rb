module OclTools
  module Timeline
    class TimelineComponent < ViewComponent::Base
      renders_many :events, EventComponent
    end
  end
end
