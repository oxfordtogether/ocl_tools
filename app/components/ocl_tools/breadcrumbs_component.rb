module OclTools
  class BreadcrumbsComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(home_path: "/")
      @links = []
      @home_path = home_path

      yield self
    end

    def link(name, path)
      @links << BreadcrumbsLink.new(name, path)
    end

    attr_reader :links, :home_path
  end

  BreadcrumbsLink = Struct.new(:name, :path)
end
