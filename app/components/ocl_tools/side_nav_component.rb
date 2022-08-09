module OclTools
  class SideNavComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize
      @links = []

      yield self
    end

    def link(name, path, icon, partial_match: false, ignore_query_params: false, active: :default)
      @links << SideNavLink.new(name, path, icon, partial_match, ignore_query_params, active)
    end

    def links
      # view components only allow you to call controller helpers like current_page? at render time
      @links.map do |link|
        is_current = if link.active == :default
          path = link.ignore_query_params ? URI(link.path).path : link.path

          link.partial_match ? request.fullpath.start_with?(path) : current_page?(path)
        else
          link.active
        end
        SideNavLinkWithActive.new(link.name, link.path, link.icon, is_current)
      end
    end
  end

  SideNavLink = Struct.new(:name, :path, :icon, :partial_match, :ignore_query_params, :active)
  SideNavLinkWithActive = Struct.new(:name, :path, :icon, :active?)
end

def link(name, path, partial_match: false)
  @links << NavTabsLink.new(name, path, partial_match)
end
