module OclTools
  class SideNavComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize
      @links = []

      yield self
    end

    def link(name, path, icon)
      @links << SideNavLink.new(name, path, icon)
    end

    def links
      # view components only allow you to call controller helpers like current_page? at render time
      @links.map do |link|
        SideNavLinkWithActive.new(link.name, link.path, link.icon, current_page?(link.path))
      end
    end
  end

  SideNavLink = Struct.new(:name, :path, :icon)
  SideNavLinkWithActive = Struct.new(:name, :path, :icon, :active?)
end
