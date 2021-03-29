module OclTools
  class AuthGenerator < Rails::Generators::Base
    include Rails::Generators::AppName
    source_root File.expand_path("templates", __dir__)

    argument :user_model, type: :string, desc: "Name of model that will hold the auth0_id"

    def create
      gem "auth0"
      gem "omniauth-auth0", "~> 2.2"
      gem "omniauth-rails_csrf_protection", "~> 0.1"

      route 'get "login", to: "auth#login"'
      route 'get "invalid_permissions", to: "auth#invalid_permissions"'
      route 'get "email_not_verified", to: "auth#email_not_verified"'
      route 'get "logout", to: "auth#logout"'
      route 'get "auth0_callback", to: "auth#callback"'
      route 'get "auth0_failure", to: "auth#failure"'

      template "auth_controller.rb", "app/controllers/auth_controller.rb"
      template "secured.rb", "app/controllers/concerns/secured.rb"

      inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\n" do
        "  include Secured\n"
      end

      copy_file "auth0.rb", "config/initializers/auth0.rb"
      copy_file "auth0.yml", "config/auth0.yml"

      template "unauthorized.html.erb", "app/views/layouts/unauthorized.html.erb"

      template "invalid_permissions.html.erb", "app/views/auth/invalid_permissions.html.erb"
      template "email_not_verified.html.erb", "app/views/auth/email_not_verified.html.erb"
      template "login.html.erb", "app/views/auth/login.html.erb"

      template "login_spec.rb", "spec/system/login_spec.rb"
      template "logout_spec.rb", "spec/system/logout_spec.rb"
      copy_file "spec_support_login.rb", "spec/support/login.rb"
    end

    private

    def user_class
      user_model.camelize
    end

    def user_var
      user_model.underscore
    end

    def app_desc
      app_name.humanize.capitalize
    end
  end
end
