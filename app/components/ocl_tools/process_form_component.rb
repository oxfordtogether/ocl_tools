module OclTools
  class ProcessFormComponent < ViewComponent::Base
    attr_reader :process

    def initialize(process, scope: nil, component: nil)
      @process = process
      @scope = scope
      @process_component = component
      super
    end

    def process_component
      @process_component || "#{process.class.to_s.split('::Process').first}::Component".constantize
    end

    def scope
      @scope || process.class.to_s.split('::Process').first.underscore
    end

    def current_path
      request.fullpath
    end
  end
end
