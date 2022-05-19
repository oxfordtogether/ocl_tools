module OclTools
  class NavTabsComponent < ViewComponent::Base
    def initialize
      super
      @links = []

      yield self
    end

    def link(name, path, partial_match: false, ignore_query_params: true)
      @links << NavTabsLink.new(name, path, partial_match, ignore_query_params)
    end

    def links
      # view components only allow you to call controller helpers like current_page? at render time
      @links.map do |link|
        path = link.ignore_query_params ? URI(link.path).path : link.path

        is_current = link.partial_match ? request.fullpath.start_with?(path) : current_page?(path)
        NavTabsLinkWithActive.new(link.name, link.path, is_current)
      end
    end
  end

  NavTabsLink = Struct.new(:name, :path, :partial_match, :ignore_query_params)
  NavTabsLinkWithActive = Struct.new(:name, :path, :active?)
end
