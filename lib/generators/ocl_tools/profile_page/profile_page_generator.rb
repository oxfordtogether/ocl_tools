module OclTools
  class ProfilePageGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)
    include Rails::Generators::ResourceHelpers

    def generate
      template "controller.rb",
               File.join("app/controllers", controller_class_path, "#{singular_name}_controller.rb")

      # generate views
      %w[_show_head.html.erb edit.html.erb timeline.html.erb edit/_personal_details.html.erb].each do |filename|
        template filename, File.join("app/views", controller_file_path, filename)
      end

      route %(
        resources :#{plural_name}, controller: :#{singular_name}, only: %i[show update] do
          member do
            get :timeline
            get :edit, path: 'edit(/:page)'
          end
        end
      ).strip_heredoc, namespace: regular_class_path
    end

    private

    def model_name
      file_name.camelize
    end

    def base_controller_class_name
      (controller_class_path + ["base"]).map!(&:camelize).join("::")
    end

    def controller_file_name
      singular_name
    end

    def permitted_params
      klass = model_name.constantize
      klass.connection
      encrypted_attributes = klass.try(:lockbox_attributes).map { |_, v| v[:encrypted_attribute] } || []
      klass.new.attribute_names - encrypted_attributes - %w[id created_at updated_at auth0_id]
    end
  end
end
