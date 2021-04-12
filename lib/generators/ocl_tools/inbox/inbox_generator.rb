module OclTools
  class InboxGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)
    include Rails::Generators::ResourceHelpers

    def generate
      template "controller.rb",
               File.join("app/controllers", controller_class_path, "#{controller_file_name}_controller.rb")

      # generate views
      %w[_index_head.html.erb index.html.erb show.html.erb].each do |filename|
        template filename, File.join("app/views", controller_file_path, filename)
      end

      route %(
      resources :#{plural_name}, except: %i[edit destroy], path: '#{plural_name}/:filter', constraints: { filter: /all|inbox/ } do
        member do
          get :next
          get :prev
        end
      end
    ), namespace: regular_class_path
    end

    private

    def arrived_at
      :submitted_at
    end

    def model_name
      file_name.camelize
    end

    def base_controller_class_name
      (controller_class_path + ["base"]).map!(&:camelize).join("::")
    end
  end
end
