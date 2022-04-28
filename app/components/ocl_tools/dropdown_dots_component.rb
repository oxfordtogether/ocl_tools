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

    def link(name, path, icon: nil, new_tab: false)
      @links << DropdownLink.new(name, path, icon, new_tab)
    end

    DropdownLink = Struct.new(:name, :path, :icon, :new_tab)
  end
end
