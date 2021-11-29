# frozen_string_literal: true

module OclTools
  class DropdownButtonComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    attr_reader :label, :links

    def initialize(label)
      @label = label
      super
      @links = []

      yield self
    end

    def link(name, path)
      @links << DropdownLink.new(name, path)
    end

    DropdownLink = Struct.new(:name, :path)
  end
end
