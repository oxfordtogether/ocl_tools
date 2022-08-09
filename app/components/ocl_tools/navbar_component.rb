# frozen_string_literal: true

module OclTools
  class NavbarComponent < ViewComponent::Base
    Link = Struct.new(:name, :path, :icon, :partial_match, :ignore_query_params)
    LinkWithActive = Struct.new(:name, :path, :icon, :active?)
    delegate :icon, to: :helpers
    renders_one :brand_area

    attr_reader :brand_name, :email, :home_path, :size

    def initialize(brand_name = nil, home_path = nil, size: "max-w-7xl")
      super
      @home_path = home_path
      @size = size
      @links = []
      @right_links = []
      @profile_links = []
      @brand_name = brand_name

      yield self
    end

    def link(name, path, partial_match: false, ignore_query_params: false, icon: nil)
      @links << Link.new(name, path, icon, partial_match, ignore_query_params)
    end

    def right_link(name, path, partial_match: false, ignore_query_params: false, icon: nil)
      @right_links << Link.new(name, path, icon, partial_match, ignore_query_params)
    end

    def profile_link(name, path, partial_match: false, ignore_query_params: false, icon: nil)
      @profile_links << Link.new(name, path, icon, partial_match, ignore_query_params)
    end

    def logged_in_as(email)
      @email = email
    end

    def links
      # view components only allow you to call controller helpers like current_page? at render time
      @links.map do |link|
        path = link.ignore_query_params ? URI(link.path).path : link.path

        is_current = link.partial_match ? request.fullpath.start_with?(path) : current_page?(path)
        LinkWithActive.new(link.name, link.path, link.icon, is_current)
      end
    end

    def right_links
      @right_links.map do |link|
        path = link.ignore_query_params ? URI(link.path).path : link.path

        is_current = link.partial_match ? request.fullpath.start_with?(path) : current_page?(path)
        LinkWithActive.new(link.name, link.path, link.icon, is_current)
      end
    end

    def profile_links
      @profile_links.map do |link|
        path = link.ignore_query_params ? URI(link.path).path : link.path

        is_current = link.partial_match ? request.fullpath.start_with?(path) : current_page?(path)
        LinkWithActive.new(link.name, link.path, link.icon, is_current)
      end
    end
  end
end
