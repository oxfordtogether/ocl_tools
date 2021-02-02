module OclTools
  module FormHelper
    def tailwind_form_with(model:, **kwargs)
      form_with(model: model, **kwargs) do |form|
        content_tag(:div) do
          yield form
        end
      end
    end
  end
end
