module OclTools
  module ComponentsHelper
    def breadcrumbs(&blk)
      render BreadcrumbsComponent.new(&blk)
    end

    def nav_tabs(&blk)
      render NavTabsComponent.new(&blk)
    end

    def notice_component(*args)
      render NoticeComponent.new(*args)
    end
  end
end
