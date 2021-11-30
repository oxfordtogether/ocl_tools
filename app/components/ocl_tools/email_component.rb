# frozen_string_literal: true

module OclTools
  class EmailComponent < ViewComponent::Base
    delegate :icon, to: :helpers
    attr_reader :email

    def initialize(email)
      @email = email
    end
  end
end
