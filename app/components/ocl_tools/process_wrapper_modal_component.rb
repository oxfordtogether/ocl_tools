module OclTools
  class ProcessWrapperModalComponent < ViewComponent::Base
    delegate :icon, :tailwind_form_with, to: :helpers
    attr_reader :process

    WIDTHS ||= %i[wide narrow].freeze

    def initialize(process, scope: nil, width: nil, component: nil)
      raise "Unknown width: #{width.inspect}. Allowed values: #{WIDTHS.map(&:inspect)}" if width && !WIDTHS.include?(width)

      @width = width || :narrow
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

    def narrow?
      @width == :narrow
    end
  end
end
