module OclTools
  class SimpleHeaderComponent < ViewComponent::Base
    renders_one :title_section
    renders_one :subtitle_section
    renders_one :body_section
    renders_one :actions_section
    renders_one :nav_tabs_section
  end
end
