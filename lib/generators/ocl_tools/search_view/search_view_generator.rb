module OclTools
  class SearchViewGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)
    include Rails::Generators::ResourceHelpers

    class_option :section, type: :string, desc: "Name of section, e.g. people"

    def generate
      @section = options["section"]
      @index_head_path = "#{class_path.join("/")}/#{@section}/index_head"

      template "index.html.erb", File.join("app/views", regular_class_path, singular_name, "index.html.erb")

      template "controller.rb", File.join("app/controllers", regular_class_path, "#{singular_name}_controller.rb")

      route %(
        get :search, to: "search#index"
      ), namespace: regular_class_path
    end

    private

    def index_path(name)
      "#{class_path.join("_")}_#{name}_path"
    end

    def model_name
      file_name.camelize
    end

    def controller_file_name
      singular_name
    end

    def base_controller_class_name
      (controller_class_path + ["base"]).map!(&:camelize).join("::")
    end
  end
end

