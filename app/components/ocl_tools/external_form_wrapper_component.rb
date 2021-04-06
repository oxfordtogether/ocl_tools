module OclTools
  class ExternalFormWrapperComponent < ViewComponent::Base
    with_content_areas :image, :title, :info, :body

    def initialize; end
  end
end
