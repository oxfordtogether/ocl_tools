# frozen_string_literal: true

module OclTools
  class PhoneNumbersComponent < ViewComponent::Base
    delegate :icon, to: :helpers
    attr_reader :phone, :mobile

    def initialize(phone, mobile)
      @phone = phone
      @mobile = mobile
    end

    def phone_numbers_string
      [phone, mobile].compact.join(" / ")
    end
  end
end
