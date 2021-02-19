module OclTools
  module ComponentsHelper
    def icon(name, options = {})
      # use icon from app if it exists, else use icon from ocl_tools
      app_icons_file = Rails.root.join("app", "icons", "#{name}.svg")
      file = if File.exist?(app_icons_file)
               File.read(app_icons_file)
             else
               File.read(OclTools::Engine.root.join("app", "icons", "#{name}.svg"))
             end

      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css "svg"

      options.each { |attr, value| svg[attr.to_s] = value }

      doc.to_html.html_safe
    end

    def breadcrumbs(&blk)
      render BreadcrumbsComponent.new(&blk)
    end

    def button_link_to(*args, **kwargs)
      render ButtonLinkToComponent.new(*args, **kwargs)
    end

    def footer(*args)
      render FooterComponent.new(*args)
    end

    def nav_tabs(&blk)
      render NavTabsComponent.new(&blk)
    end

    def notice_component(*args)
      render NoticeComponent.new(*args)
    end

    def pagination(*args)
      render PaginationComponent.new(*args)
    end

    def side_nav(&blk)
      render SideNavComponent.new(&blk)
    end

    def table(*args, row_url: nil, &blk)
      render TableComponent.new(*args, row_url: row_url, &blk)
    end
  end
end
