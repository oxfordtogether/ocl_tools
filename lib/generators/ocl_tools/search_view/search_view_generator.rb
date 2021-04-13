module OclTools
  class SearchViewGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)
    include Rails::Generators::ResourceHelpers

    class_option :section, type: :string, desc: "Name of section, e.g. people"
    class_option :namespace, type: :string, desc: "Namespace, e.g. admin"

    def generate
      @section = options["section"]
      @namespace = options["namespace"]
      @index_head_path = "#{@section}/index_head"

      template "index.html.erb", File.join("app/views", regular_class_path, singular_name, "index.html.erb")

      template "controller.rb", File.join("app/controllers", regular_class_path, "#{singular_name}_controller.rb")

      route %(
      get :search
      ), namespace: regular_class_path
    end

    private

    def index_path(namespace, name)
      "#{namespace}_#{name}_path"
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

