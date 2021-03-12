module OclTools
  class IconSelectComponent < ViewComponent::Base
    delegate :icon, to: :helpers

    def initialize(name, id, select_options, value: nil)
      @name = name
      @id = id
      @value = value

      @select_options = select_options
    end
  end
end
