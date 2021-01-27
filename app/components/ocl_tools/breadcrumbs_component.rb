module OclTools
  class BreadcrumbsComponent < ViewComponent::Base
    include ApplicationHelper # TO DO: is this the best thing to do?

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
