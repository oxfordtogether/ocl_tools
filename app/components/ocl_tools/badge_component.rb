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

    def initialize(text, style)
      @text = text
      @style = STYLES.find { |s| s.name == style } or raise "Unrecognised style: #{style}. Allowed styles: #{STYLES.map(&:name).join(', ')}"
    end

    attr_reader :text, :style
  end
end
