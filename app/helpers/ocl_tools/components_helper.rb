module OclTools
  module ComponentsHelper
    def icon(name, options = {})
      # use icon from app if it exists, else use icon from ocl_tools
      app_icons_file = Rails.root.join('app', 'icons', "#{name}.svg")
      file = if File.exist?(app_icons_file)
        File.read(app_icons_file)
      else
        File.read(OclTools::Engine.root.join('app', 'icons', "#{name}.svg"))
      end

      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css 'svg'

      options.each { |attr, value| svg[attr.to_s] = value }

      doc.to_html.html_safe
    end

    def alert(*args, **kwargs, &blk)
      render(AlertComponent.new(*args, **kwargs), &blk)
    end

    def breadcrumbs(*args, &blk)
      render BreadcrumbsComponent.new(*args, &blk)
    end

    def button_link_to(*args, **kwargs)
      render ButtonLinkToComponent.new(*args, **kwargs)
    end

    def filter_button(*args, **kwargs)
      render FilterButtonComponent.new(*args, **kwargs)
    end

    def badge(*args, **kwargs)
      render BadgeComponent.new(*args, **kwargs)
    end

    def footer(*args)
      render FooterComponent.new(*args)
    end

    def info(*args)
      render InfoComponent.new(*args)
    end

    def nav_tabs(&blk)
      render NavTabsComponent.new(&blk)
    end

    def navbar(brand_name, home_path: '/', size: 'max-w-7xl', &blk)
      render NavbarComponent.new(brand_name, home_path, size: size, &blk)
    end

    def notice_component(*args)
      render NoticeComponent.new(*args)
    end

    def pagination(*args)
      render PaginationComponent.new(*args)
    end

    def page_progress(*args)
      render PageProgressComponent.new(*args)
    end

    def profile_initials(*args)
      render ProfileInitialsComponent.new(*args)
    end

    def side_nav(&blk)
      render SideNavComponent.new(&blk)
    end

    def header(*args, &blk)
      render HeaderComponent.new(*args, &blk)
    end

    def search(*args, &blk)
      render SearchComponent.new(*args, &blk)
    end

    def table(*args, **kwargs, &blk)
      render TableComponent.new(*args, **kwargs, &blk)
    end

    def timeline(*args, **kwargs, &blk)
      render(Timeline::TimelineComponent.new(*args, **kwargs), &blk)
    end

    def full_page_dialog(*args, **kwargs, &blk)
      render(FullPageDialogComponent.new(*args, **kwargs), &blk)
    end

    def external_form_wrapper(*args, **kwargs, &blk)
      render(ExternalFormWrapperComponent.new(*args, **kwargs), &blk)
    end

    def inbox_show_body(*args, &blk)
      render InboxShowBodyComponent.new(*args, &blk)
    end

    def dropdown_button(label, &blk)
      render DropdownButtonComponent.new(label, &blk)
    end

    def dropdown_dots(*args, **kwargs, &blk)
      render DropdownDotsComponent.new(*args, **kwargs, &blk)
    end

    def button_link_group(*args, **kwargs, &blk)
      render(ButtonLinkGroupComponent.new(*args, **kwargs, &blk))
    end

    def option_badge(option)
      return if option.nil?

      square_badge(option.label, option.colour)
    end

    def square_badge(label, colour)
      classes = BadgeColour.css(colour)
      tag.span label, class: "inline-flex items-center px-2 py-0.5 rounded text-xs font-medium #{classes}"
    end

    def back_with_icon_link(*args, **kwargs)
      render BackWithIconLinkComponent.new(*args, **kwargs)
    end
  end
end
