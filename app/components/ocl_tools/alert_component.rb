module OclTools
  class AlertComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    attr_reader :title, :type, :info

    SUPPORTED_TYPES ||= %i[warn info danger].freeze

    def initialize(title: nil, info: nil, type: :warn)
      @title = title
      @info = info
      raise "Unsupported type: #{type}" unless SUPPORTED_TYPES.include?(type)

      @type = type
    end

    def warn?
      type == :warn
    end

    def info?
      type == :info
    end

    def danger?
      type == :danger
    end
  end
end
