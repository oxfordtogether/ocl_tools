# frozen_string_literal: true
module OclTools
  class AddressLineComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    attr_reader :address

    def initialize(address)
      @address = address
    end

    def address_line
      return nil if address.nil?

      [address.line_1, address.line_2, address.line_3, address.town, address.postcode].compact.join(", ")
    end
  end
end
