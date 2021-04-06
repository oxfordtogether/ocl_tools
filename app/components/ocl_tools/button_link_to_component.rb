module OclTools
  class ButtonLinkToComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    Style = Struct.new(:name, :link_classes, :icon_classes)
    STYLES = [
      Style.new("gray-outline", "border-gray-300 text-gray-700 bg-white hover:bg-gray-50", "text-gray-500"),
      Style.new("primary-outline", "border-transparent text-primary-700 bg-primary-100 hover:bg-primary-200", "text-primary-500"),
      Style.new("primary-filled", "border-transparent text-white bg-primary-600 hover:bg-primary-700", "text-white"),
    ]

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

      @style = STYLES.find { |s| s.name == style } or raise "Unrecognised style: #{style}"
      @size = SIZES.find { |s| s.name == size } or raise "Unrecognised size: #{size}"
    end

    attr_reader :text, :path, :style, :size, :icon_name, :options
  end
end
