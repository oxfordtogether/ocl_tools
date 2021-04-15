module OclTools
  class FileUploadComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(form:, field:, **options)
      @field = field
      @form = form
      @options = options
    end
  end
end
