module OclTools
  module ComponentsHelper
    def icon(name, options = {})
      file = File.read(OclTools::Engine.root.join("app", "icons", "#{name}.svg"))
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css "svg"

      options.each { |attr, value| svg[attr.to_s] = value }

      doc.to_html.html_safe
    end

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
