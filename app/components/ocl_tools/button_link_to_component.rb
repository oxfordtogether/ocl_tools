module OclTools
  class ButtonLinkToComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    Size = Struct.new(:name, :link_classes, :icon_classes)
    SIZES = [
      Size.new("very_small", "px-2 py-0.5 text-xs", "-ml-0.5 mr-1 h-4 w-4"),
      Size.new("small", "px-2 py-1 text-sm", "-ml-0.5 mr-1 h-4 w-4"),
      Size.new("normal", "px-4 py-2 text-sm", "-ml-1 mr-2 h-5 w-5"),
    ]

    def initialize(text, path, options: {}, style: "gray-outline", size: "normal", icon: nil)
      @text = text
      @path = path
      @icon_name = icon
      @options = options

      @style = ButtonStyle.find(style)
      @size = SIZES.find { |s| s.name == size } or raise(SizeError, size)
    end

    attr_reader :text, :path, :style, :size, :icon_name, :options

    class SizeError < ArgumentError
      def initialize(size)
        @size = size
      end

      def message
        "Unrecognised size: #{@size}. Allowed styles: #{SIZES.map(&:name).join(', ')}"
      end
    end
  end
end
