module OclTools
  class NavTabsComponent < ViewComponent::Base
    def initialize
      @links = []

      yield self
    end

    def link(name, path)
      @links << NavTabsLink.new(name, path)
    end

    def links
      # view components only allow you to call controller helpers like current_page? at render time
      @links.map do |link|
        NavTabsLinkWithActive.new(link.name, link.path, current_page?(link.path))
      end
    end
  end

  NavTabsLink = Struct.new(:name, :path)
  NavTabsLinkWithActive = Struct.new(:name, :path, :active?)
end
