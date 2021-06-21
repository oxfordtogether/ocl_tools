module OclTools
  class ModalComponent < ViewComponent::Base
    renders_one :title
    renders_one :body

    attr_reader :modal_width

    def initialize(modal_width: "max-w-lg")
      @modal_width = modal_width
    end
  end
end
