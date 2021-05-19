module OclTools
  class ExternalFormWrapperComponent < ViewComponent::Base
    renders_one :image
    renders_one :title
    renders_one :info
    renders_one :body
  end
end
