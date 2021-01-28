module OclTools
  module ComponentsHelper
    def breadcrumbs(&blk)
      render BreadcrumbsComponent.new(&blk)
    end
  end
end
