module OclTools
  class SideNavComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize
      @links = []

      yield self
    end

    def link(name, path, icon, partial_match: false)
      @links << SideNavLink.new(name, path, icon, partial_match)
    end

    def links
      # view components only allow you to call controller helpers like current_page? at render time
      @links.map do |link|
        is_current = link.partial_match ? request.fullpath.start_with?(link.path) : current_page?(link.path)
        SideNavLinkWithActive.new(link.name, link.path, link.icon, is_current)
      end
    end
  end

  SideNavLink = Struct.new(:name, :path, :icon, :partial_match)
  SideNavLinkWithActive = Struct.new(:name, :path, :icon, :active?)
end

def link(name, path, partial_match: false)
  @links << NavTabsLink.new(name, path, partial_match)
end
