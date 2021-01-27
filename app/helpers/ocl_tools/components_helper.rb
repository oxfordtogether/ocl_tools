module OclTools
  module ComponentsHelper
    def breadcrumbs(&blk)
      render BreadcrumbsComponent.new(&blk)
    end

    def simple()
      render SimpleComponent.new()
    end
  end
end
