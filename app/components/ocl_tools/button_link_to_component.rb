module OclTools
  class ButtonLinkToComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    Style = Struct.new(:name, :link_classes, :icon_classes)
    STYLES = [
      Style.new("gray-outline", "border-gray-300 text-gray-700 bg-white hover:bg-gray-50", "text-gray-500"),
      Style.new("primary-outline", "border-transparent text-primary-700 bg-primary-100 hover:bg-primary-200", "text-primary-500"),
      Style.new("primary-filled", "border-transparent text-white bg-primary-600 hover:bg-primary-700", "text-white"),
    ]

    def initialize(text, path, options: {}, style: "gray-outline", icon: nil)
      @text = text
      @path = path
      @icon_name = icon
      @options = options

      @style = STYLES.find { |s| s.name == style } or raise "Unrecognised style: #{style}"
    end

    attr_reader :text, :path, :style, :icon_name, :options
  end
end
