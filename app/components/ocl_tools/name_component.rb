# frozen_string_literal: true
module OclTools
  class NameComponent < ViewComponent::Base
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
