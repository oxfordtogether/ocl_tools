# frozen_string_literal: true

module OclTools
  module Address
    class Component < ViewComponent::Base
      delegate :icon, to: :helpers

      attr_reader :address

      def initialize(address)
        @address = address
      end

      def address_line
        address&.single_line
      end
    end
  end
end
