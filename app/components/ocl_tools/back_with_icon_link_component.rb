module OclTools
  class BackWithIconLinkComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(form, label, options)
      @form = form
      @label = label
      @options = options
    end

    attr_reader :form, :method
  end
end
