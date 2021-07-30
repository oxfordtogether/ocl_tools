module OclTools
  class FilterButtonComponent < ViewComponent::Base
    Style = Struct.new(:name, :select_bg, :hover_bg)
    STYLES = [
      Style.new("blue", "bg-blue-300", "bg-blue-400"),
      Style.new("green", "bg-green-300", "bg-green-400"),
      Style.new("yellow", "bg-yellow-300", "bg-yellow-400"),
    ]

    def initialize(text, path, style: "yellow")
      @text = text
      @path = path

      @style = STYLES.find { |s| s.name == style } or raise "Unrecognised style: #{style}"
    end

    def is_current
      current_page?(path)
    end

    attr_reader :text, :path, :style
  end
end
