module OclTools
  module FormHelper
    def tailwind_form_with(model: nil, **kwargs)
      form_with(model: model, builder: TailwindFormBuilder, **kwargs) do |form|
        content_tag(:div, { data: { controller: "better-conditional-fields"} }) do
          yield form
        end
      end
    end

    def grouped_and_ungrouped_options_for_select(grouped_options, selected_key = nil)
      # e.g.
      # grouped_options:
      # [
      #   nil, [["a", :a], ["b": :b]],         # <- no group header
      #   "group_1", [["c", :c], ["d": :d]],
      #   "group_2", [["e", :e],
      # ]
      # <%= form.select :blah, grouped_and_ungrouped_options_for_select(blah_options) %>

      body = ""
      grouped_options.each do |group_label, group_options|
        if group_label.nil?
          group_options.each do |label, value|
            selected = selected_key == value
            body << content_tag(:option, label, value: value, selected: selected)
          end
        else
          group_html = content_tag :optgroup, label: group_label do
            group_options.map do |label, value|
              selected = selected_key == value
              concat(content_tag(:option, label, value: value, selected: selected))
            end
          end
          body << group_html

        end
      end
      body.html_safe
    end
  end
end
