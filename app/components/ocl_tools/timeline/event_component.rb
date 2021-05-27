# frozen_string_literal: true

module OclTools
  module Timeline
    class EventComponent < ViewComponent::Base
      renders_one :title
      renders_one :meta
      renders_one :body

      delegate :icon, to: :helpers

      attr_reader :icon_name, :icon_colour, :time

      def initialize(icon:, icon_colour:, time:)
        @icon_name = icon
        @icon_colour = icon_colour
        @time = time
        super
      end
    end
  end
end
