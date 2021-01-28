require "view_component/engine"

module OclTools
  class Engine < ::Rails::Engine
    isolate_namespace OclTools

    config.app_middleware.use(
      Rack::Static,
      urls: ["/ocl-tools-packs"], root: OclTools::Engine.root.join("public")
    )

    initializer "webpacker.proxy" do |app|
      insert_middleware = begin
                          OclTools.webpacker.config.dev_server.present?
                        rescue
                          nil
                        end
      next unless insert_middleware

      app.middleware.insert_before(
        0, Webpacker::DevServerProxy,
        ssl_verify_none: true,
        webpacker: OclTools.webpacker
      )
    end
  end
end
