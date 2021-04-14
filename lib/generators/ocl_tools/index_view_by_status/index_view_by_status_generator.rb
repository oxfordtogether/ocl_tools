module OclTools
  class IndexViewByStatusGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)
    include Rails::Generators::ResourceHelpers

    class_option :section, type: :string, desc: "Name of section, e.g. people"
    class_option :namespace, type: :string, desc: "Namespace, e.g. admin"

    def generate
      @section = options["section"]
      @namespace = options["namespace"]
      @index_head_path = "#{@namespace}/#{@section}/index_head"

      @statuses = model_name.constantize.send("status_options_for_select").map(&:reverse).to_h

      template "index.html.erb", File.join("app/views", regular_class_path, plural_name, "index.html.erb")

      template "controller.rb", File.join("app/controllers", regular_class_path, "#{plural_name}_controller.rb")

      route %(
        resources :#{plural_name}, only: %i[index], path: "#{plural_name}/(:status)", constraints: { status: /all|#{@statuses.keys.join("|")}/ }
      ), namespace: regular_class_path
    end

    private

    def index_path(namespace, name)
      "#{namespace}_#{name}_path"
    end

    def model_name
      file_name.camelize
    end

    def base_controller_class_name
      (controller_class_path + ["base"]).map!(&:camelize).join("::")
    end
  end
end

