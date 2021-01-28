module OclTools
  class FormErrorComponent < ViewComponent::Base
    def initialize(model)
      @model = model.is_a?(Array) ? model.last : model
    end

    attr_accessor :model
  end
end
