module OclTools
  class BadgeComponent < ViewComponent::Base
    Style = Struct.new(:name, :text_colour, :bg_colour)
    STYLES = [
      Style.new("pale-red", "text-gray-800", "bg-red-100"),
      Style.new("pale-green", "text-gray-800", "bg-green-100"),
      Style.new("pale-yellow", "text-gray-800", "bg-yellow-100"),
      Style.new("pale-blue", "text-gray-800", "bg-blue-100"),
      Style.new("pale-purple", "text-gray-800", "bg-purple-100"),
      Style.new("purple", "text-gray-900", "bg-purple-300"),
      Style.new("pale-gray", "text-gray-800", "bg-gray-100"),
      Style.new("yellow", "text-gray-800", "bg-yellow-300"),
    ]

    Size = Struct.new(:name, :classes)
    SIZES = [
      Size.new("small", "px-2.5 py-0.5 text-xs"),
      Size.new("large", "px-3 py-0.5 text-sm"),
    ]

    def initialize(text, style, size: "large")
      @text = text
      @style = STYLES.find { |s| s.name == style.to_s } or raise(StyleError, style)
      @size = SIZES.find { |s| s.name == size.to_s } or raise(SizeError, size)
    end

    attr_reader :text, :style, :size

    class StyleError < ArgumentError
      def initialize(style)
        @style = style
      end

      def message
        "Unrecognised style: #{@style}. Allowed styles: #{STYLES.map(&:name).join(', ')}"
      end
    end

    class SizeError < ArgumentError
      def initialize(size)
        @size = size
      end

      def message
        "Unrecognised size: #{@size}. Allowed sizes: #{SIZES.map(&:name).join(', ')}"
      end
    end
  end
end
