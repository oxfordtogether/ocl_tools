module OclTools
  class BreadcrumbsComponent < ViewComponent::Base
    delegate :icon, to: :helpers
    def initialize
      @links = []

      yield self
    end

    def link(name, path)
      @links << BreadcrumbsLink.new(name, path)
    end

    attr_reader :links
  end

  BreadcrumbsLink = Struct.new(:name, :path)
end
