module OclTools
  class FilterGroupComponent < ViewComponent::Base
    attr_reader :params, :key, :options, :include_all, :size

    def initialize(params, key:, options:, include_all: true, size: 'very_small')
      @params = params
      @key = key
      @options = options
      @include_all = include_all
      @size = SIZES.find { |s| s.name == size } or raise(SizeError, size)
    end

    Size = Struct.new(:name, :link_classes)
    SIZES = [
      Size.new('very_small', 'px-2 py-0.5 text-xs'),
      Size.new('small', 'px-2 py-1 text-sm'),
      Size.new('normal', 'px-4 py-2 text-base')
    ]
    class SizeError < ArgumentError
      def initialize(size)
        @size = size
      end

      def message
        "Unrecognised size: #{@size}. Allowed styles: #{SIZES.map(&:name).join(', ')}"
      end
    end
  end
end
