module OclTools
  class TabSectionGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)
    include Rails::Generators::ResourceHelpers

    class_option :tabs, type: :array, desc: "List of tabs e.g. 'search bigs littles ...'"

    def generate
      @tabs = options["tabs"]

      template "_index_head.html.erb", File.join("app/views", regular_class_path, file_name, "_index_head.html.erb")

      route %(
        get :#{file_name}, to: redirect("/#{class_path.join('/')}/#{@tabs[0]}")
      ).strip_heredoc, namespace: regular_class_path
    end

    private

    def index_path(tab)
      "#{class_path.join('_')}_#{tab}_path"
    end
  end
end
