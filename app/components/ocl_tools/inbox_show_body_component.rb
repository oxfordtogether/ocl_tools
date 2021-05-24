module OclTools
  class InboxShowBodyComponent < ViewComponent::Base
    def call_block(*args, &blk)
      view_context.capture(*args, &blk)
    end

    Status = Struct.new(:inbox_show_body, :blk) do
      def contents(*args)
        inbox_show_body.call_block(*args, &blk)
      end
    end

    SubHeader = Struct.new(:inbox_show_body, :blk) do
      def contents(*args)
        inbox_show_body.call_block(*args, &blk)
      end
    end

    RightAlignedActions = Struct.new(:inbox_show_body, :blk) do
      def contents(*args)
        inbox_show_body.call_block(*args, &blk)
      end
    end


    delegate :icon, to: :helpers

    attr_reader :section_blocks, :name, :subtitle, :status_blk, :sub_header_blk, :right_aligned_actions_blk

    def initialize(name, subtitle = nil)
      super

      @name = name
      @subtitle = subtitle

      @status_blk = nil
      @sub_header_blk = nil
      @right_aligned_actions_blk = nil

      @section_blocks = []

      yield self
    end

    def section_block(title, &blk)
      sblk = SectionBlock.new(title, &blk)
      yield sblk
      @section_blocks << sblk
    end

    def status(&blk)
      @status_blk = Status.new(self, blk)
    end

    def sub_header(&blk)
      @sub_header_blk = SubHeader.new(self, blk)
    end

    def right_aligned_actions(&blk)
      @right_aligned_actions_blk = RightAlignedActions.new(self, blk)
    end
  end

  class SectionBlock
    def initialize(title)
      @title = title
      @label_and_texts = []
    end

    attr_reader :title, :label_and_texts

    LabelAndText = Struct.new(:label, :text)

    def label_and_text(label, text)
      @label_and_texts << LabelAndText.new(label, text)
    end
  end
end
