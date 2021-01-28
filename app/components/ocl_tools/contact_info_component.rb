module OclTools
  class ContactInfoComponent < ViewComponent::Base
    delegate :icon, to: :helpers
    delegate :address_to_string, to: :helpers

    def initialize(person:)
      @person = person
    end
  end
end
