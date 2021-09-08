class ButtonStyle < Struct.new(:name, :link_classes, :icon_classes)
  def self.all
    [
      new("gray-outline", "border-gray-300 text-gray-700 bg-white hover:bg-gray-50", "text-gray-500"),
      new("primary-outline", "border-transparent text-primary-700 bg-primary-100 hover:bg-primary-200", "text-primary-500"),
      new("primary-filled", "border-transparent text-white bg-primary-600 hover:bg-primary-700", "text-white"),
      new("danger", "border-transparent text-white bg-red-600 hover:bg-red-700", "text-white")
    ]
  end

  def self.find(id)
    all.find { |s| s.name == id.to_s } or raise(StyleError, style)
  end

  class StyleError < ArgumentError
    def initialize(style)
      @style = style
    end

    def message
      "Unrecognised style: #{@style}. Allowed styles: #{ButtonStyle.all.map(&:name).join(', ')}"
    end
  end
end
