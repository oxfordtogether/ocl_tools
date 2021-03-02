module OclTools
  class ButtonLinkToComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(text, path, type, icon: nil)
      @text = text
      @path = path
      @type = type
      @icon_name = icon
    end

    attr_reader :text, :path, :type, :icon_name
  end
end
