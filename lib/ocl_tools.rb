require "ocl_tools/engine"

module OclTools
  class << self
    def webpacker
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: OclTools::Engine.root,
        config_path: OclTools::Engine.root.join('config', 'Webpacker.yml')
      )
    end
  end
end
