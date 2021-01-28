module OclTools
  class FileUploadComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(form:, field:)
      @field = field
      @form = form
    end
  end
end
