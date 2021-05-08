module OclTools
  class ModalComponent < ViewComponent::Base
    renders_one :title
    renders_one :body

    def initialize; end
  end
end
