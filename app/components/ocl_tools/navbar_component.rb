# frozen_string_literal: true

module OclTools
  class NavbarComponent < ViewComponent::Base
    Link = Struct.new(:name, :path, :icon, :partial_match)
    LinkWithActive = Struct.new(:name, :path, :icon, :active?)
    delegate :icon, to: :helpers

    attr_reader :brand_name, :email, :home_path

    def initialize(brand_name, home_path)
      super
      @home_path = home_path
      @links = []
      @right_links = []
      @profile_links = []
      @brand_name = brand_name

      yield self
    end

    def link(name, path, partial_match: false, icon: nil)
      @links << Link.new(name, path, icon, partial_match)
    end

    def right_link(name, path, partial_match: false, icon: nil)
      @right_links << Link.new(name, path, icon, partial_match)
    end

    def profile_link(name, path, partial_match: false, icon: nil)
      @profile_links << Link.new(name, path, icon, partial_match)
    end

    def logged_in_as(email)
      @email = email
    end

    def links
      # view components only allow you to call controller helpers like current_page? at render time
      @links.map do |link|
        is_current = link.partial_match ? request.fullpath.start_with?(link.path) : current_page?(link.path)
        LinkWithActive.new(link.name, link.path, link.icon, is_current)
      end
    end

    def right_links
      @right_links.map do |link|
        is_current = link.partial_match ? request.fullpath.start_with?(link.path) : current_page?(link.path)
        LinkWithActive.new(link.name, link.path, link.icon, is_current)
      end
    end

    def profile_links
      @profile_links.map do |link|
        is_current = link.partial_match ? request.fullpath.start_with?(link.path) : current_page?(link.path)
        LinkWithActive.new(link.name, link.path, link.icon, is_current)
      end
    end
  end
end
