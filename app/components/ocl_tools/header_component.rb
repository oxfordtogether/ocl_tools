module OclTools
  class HeaderComponent < ViewComponent::Base
    Heading = Struct.new(:header_component, :blk) do
      def contents(*args)
        header_component.call_block(*args, &blk)
      end
    end

    SubHeading = Struct.new(:header_component, :blk) do
      def contents(*args)
        header_component.call_block(*args, &blk)
      end
    end

    Badge = Struct.new(:header_component, :blk) do
      def contents(*args)
        header_component.call_block(*args, &blk)
      end
    end

    Action = Struct.new(:header_component, :blk) do
      def contents(*args)
        header_component.call_block(*args, &blk)
      end
    end

    IconAndText = Struct.new(:icon, :text)

    LabelAndText = Struct.new(:label, :text)

    NavTabsSection = Struct.new(:header_component, :blk) do
      def contents(*args)
        header_component.call_block(*args, &blk)
      end
    end

    def call_block(*args, &blk)
      view_context.capture(*args, &blk)
    end

    delegate :icon, to: :helpers

    attr_reader :headings, :sub_headings, :badges, :actions, :icon_and_texts, :label_and_texts, :nav_tabs_sections

    def initialize
      super
      @headings = []
      @sub_headings = []

      @badges = []
      @actions = []

      @icon_and_texts = []
      @label_and_texts = []

      @nav_tabs_sections = nil

      yield self
    end

    def heading(&blk)
      @headings << Heading.new(self, blk)
    end

    def sub_heading(&blk)
      @sub_headings << SubHeading.new(self, blk)
    end

    def badge(&blk)
      @badges << Badge.new(self, blk)
    end

    def action(&blk)
      @actions << Action.new(self, blk)
    end

    def icon_and_text(icon, text)
      @icon_and_texts << IconAndText.new(icon, text)
    end

    def label_and_text(label, text)
      @label_and_texts << LabelAndText.new(label, text)
    end

    def nav_tabs_section(&blk)
      @nav_tabs_sections = NavTabsSection.new(self, blk)
    end

    def nav_tabs_test(*args)
      @nav_tabs_tests = NavTabsComponent.new(*args)
    end
  end
end
