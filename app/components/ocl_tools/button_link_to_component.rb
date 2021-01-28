module OclTools
  class ButtonLinkToComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(text, path, icon: nil)
      @text = text
      @path = path
      @icon_name = icon
    end

    attr_reader :text, :path, :icon_name
  end
end
