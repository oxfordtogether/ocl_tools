module OclTools
  class ProfileInitialsComponent < ViewComponent::Base
    def initialize(initials:)
      @initials = initials
      @scheme = scheme
    end

    # pick a colour scheme in an arbitrary but predictable way
    def scheme
      @initials[0].ord % 5
    end
  end
end
