# frozen_string_literal: true

module OclTools
  class DropdownDotsComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    attr_reader :links

    def initialize
      super
      @links = []

      yield self
    end

    def link(name, path, icon: nil)
      @links << DropdownLink.new(name, path, icon)
    end

    DropdownLink = Struct.new(:name, :path, :icon)
  end
end
