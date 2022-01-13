# frozen_string_literal: true

module OclTools
  class ButtonLinkGroupComponent < ViewComponent::Base
    attr_reader :size

    def initialize(size: 'small')
      @links = []
      @size = SIZES.find { |s| s.name == size } or raise(SizeError, size)

      yield self
    end

    Size = Struct.new(:name, :link_classes)
    SIZES = [
      Size.new('very_small', 'px-2 py-0.5 text-xs'),
      Size.new('small', 'px-2 py-1 text-sm'),
      Size.new('normal', 'px-4 py-2 text-base')
    ]

    def link(name, path, partial_match: false)
      @links << Link.new(name, path, partial_match)
    end

    def links
      # view components only allow you to call controller helpers like current_page? at render time
      @links.map do |link|
        is_current = link.partial_match ? request.fullpath.start_with?(link.path) : current_page?(link.path)
        LinkWithActive.new(link.name, link.path, is_current)
      end
    end

    Link = Struct.new(:name, :path, :partial_match)
    LinkWithActive = Struct.new(:name, :path, :active?)

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


