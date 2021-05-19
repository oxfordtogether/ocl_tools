module OclTools
  class FullPageDialogComponent < ViewComponent::Base
    renders_one :image
    renders_one :title
    renders_one :subtitle
    renders_one :button
  end
end
