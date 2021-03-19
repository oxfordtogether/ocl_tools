module OclTools
  class NavTabsComponent < ViewComponent::Base
    def initialize
      super
      @links = []

      yield self
    end

    def link(name, path, partial_match: false)
      @links << NavTabsLink.new(name, path, partial_match)
    end

    def links
      # view components only allow you to call controller helpers like current_page? at render time
      @links.map do |link|
        is_current = link.partial_match ? request.fullpath.start_with?(link.path) : current_page?(link.path)
        NavTabsLinkWithActive.new(link.name, link.path, is_current)
      end
    end
  end

  NavTabsLink = Struct.new(:name, :path, :partial_match)
  NavTabsLinkWithActive = Struct.new(:name, :path, :active?)
end
