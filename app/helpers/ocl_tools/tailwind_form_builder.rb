module OclTools
  class TailwindFormBuilder < ActionView::Helpers::FormBuilder
    INPUT_CLASSES = 'shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md'.freeze
    INPUT_ERROR_CLASSES = 'shadow-sm block w-full sm:text-sm rounded-md border-red-300 text-red-900 placeholder-red-900 focus:outline-none focus:ring-red-500 focus:border-red-500'.freeze
    COL_OPTIONS = { full: 'sm:col-span-6', two_thirds: 'sm:col-span-4', half: 'sm:col-span-3', third: 'sm:col-span-2', sixth: 'sm:col-span-1' }.freeze

    alias orig_label label

    def label(field, label = nil, description: nil, required_asterix: false)
      label_text = super(field, label)
      label_text += @template.content_tag(:div, '*', class: 'ml-1 text-red-500') if required_asterix

      description_text = (@template.content_tag(:div, description, class: 'mt-1 mb-2 text-gray-500 text-xs') if description)

      @template.content_tag :div, class: 'flex text-sm font-medium text-gray-700' do
        label_text_div = @template.content_tag(:div, label_text, class: 'flex')
        @template.content_tag(:div, label_text_div + description_text)
      end
    end

    def error(message)
      @template.content_tag(:p, message, class: 'mt-1 text-sm text-red-600')
    end

    def info(message)
      @template.content_tag(:p, message, class: 'mt-1 text-xs text-gray-400')
    end

    def paragraph(label, description = nil, width: :full)
      col_class = COL_OPTIONS.fetch(width || :full)

      @template.content_tag :div, class: col_class.to_s do
        p = @template.content_tag(:p, label, class: 'flex text-sm font-medium')
        p += @template.content_tag(:p, description, class: 'flex text-sm text-gray-700') if description

        p
      end
    end

    alias orig_text_field text_field
    alias orig_file_field file_field

    def text_field(field, label: nil, description: nil, width: nil, required_asterix: false, info_message: nil, **kwargs)
      errors = object ? object.errors[field] : []
      kwargs[:class] = errors.empty? ? INPUT_CLASSES : INPUT_ERROR_CLASSES

      tailwind_field(field, label, description: description, width: width, required_asterix: required_asterix) do
        super(field, **kwargs) + error(errors.last) + info(info_message)
      end
    end

    def text_area(field, label: nil, description: nil, width: nil, required_asterix: false, info_message: nil, **options)
      errors = object ? object.errors[field] : []
      options = options.merge({ class: errors.empty? ? INPUT_CLASSES : INPUT_ERROR_CLASSES })

      tailwind_field(field, label, description: description, width: width, required_asterix: required_asterix) do
        super(field, **options) + error(errors.last) + info(info_message)
      end
    end

    def email_field(field, label: nil, width: nil, description: nil, required_asterix: false, info_message: nil, **options)
      errors = object ? object.errors[field] : []
      options = options.merge({ class: errors.empty? ? INPUT_CLASSES : INPUT_ERROR_CLASSES })

      tailwind_field(field, label, width: width, description: description, required_asterix: required_asterix) do
        super(field, **options) + error(errors.last) + info(info_message)
      end
    end

    def number_field(field, label: nil, width: nil, description: nil, required_asterix: false, info_message: nil, **options)
      errors = object ? object.errors[field] : []
      options = options.merge({
        class: errors.empty? ? INPUT_CLASSES : INPUT_ERROR_CLASSES,
        onwheel: 'this.blur()' # disable scrolling with the mouse wheel
      })

      tailwind_field(field, label, description: description, width: width, required_asterix: required_asterix) do
        super(field, **options) + error(errors.last) + info(info_message)
      end
    end

    def rich_text_area(field, label: nil, description: nil, width: nil, required_asterix: false, info_message: nil, **options)
      errors = object ? object.errors[field] : []
      existing_classes = options[:class]
      classes = "#{errors.empty? ? INPUT_CLASSES : INPUT_ERROR_CLASSES} #{existing_classes}".strip
      options = options.merge({ class: classes })

      tailwind_field(field, label, width: width, description: description, required_asterix: required_asterix) do
        super(field, **options) + error(errors.last) + info(info_message)
      end
    end

    def file_field(field, label: nil, width: nil, description: nil, required_asterix: false, info_message: nil, **opts)
      errors = object ? object.errors[field] : []

      tailwind_field(field, label, width: width, description: description, required_asterix: required_asterix) do
        @template.render(FileUploadComponent.new(form: self, field: field, **opts)) + error(errors.last) + info(info_message)
      end
    end

    def select(field, options, include_blank: true, label: nil, description: nil, width: nil, required_asterix: false, info_message: nil, can_condition_on: false, html_options: {})
      errors = object ? object.errors[field] : []

      choices = include_blank ? { include_blank: 'Select...' } : {}
      classes = errors.empty? ? INPUT_CLASSES : INPUT_ERROR_CLASSES

      html_options.merge!({ 'data-better-conditional-fields-target' => 'source', "data-name": field }) if can_condition_on

      tailwind_field(field, label, width: width, description: description, required_asterix: required_asterix) do
        super(field, options, choices, html_options.merge({ class: classes })) + error(errors.last) + info(info_message)
      end
    end

    def conditional(display_if: nil, display_unless: nil, width: :full, &block)
      raise "You must provide exactly one of display_if and display_unless. Currently display_if=#{display_if.inspect}, display_unless=#{display_unless.inspect}" if (display_if.nil? && display_unless.nil?) || (display_if && display_unless)

      col_class = COL_OPTIONS.fetch(width || :full)
      condition = display_if ? { display_if: display_if } : { display_unless: display_unless }

      @template.content_tag :div, class: "#{col_class} grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6", data: { better_conditional_fields_target: :target }.merge(condition), &block
    end

    def collection_select(method, collection, value_method, text_method, description: nil, include_blank: true, width: nil, required_asterix: false, info_message: nil, html_options: {}, **options)
      errors = object ? object.errors[method] : []

      label = options[:label]
      disabled = options[:disabled] || false
      options[:include_blank] = 'Select...' if include_blank
      classes = errors.empty? ? INPUT_CLASSES : INPUT_ERROR_CLASSES

      tailwind_field(method, label, width: width, description: description, required_asterix: required_asterix) do
        super(method, collection, value_method, text_method, options, html_options.merge({ class: classes, disabled: disabled })) + error(errors.last) + info(info_message)
      end
    end

    def date_picker(method, placeholder = 'Select...', label: nil, description: nil, width: nil, disabled: false, start_year: nil, end_year: nil, required_asterix: false, info_message: nil, options: {})
      errors = object ? object.errors[method] : []
      names = { "year": name_for("#{method}(1i)"), "month": name_for("#{method}(2i)"),
                "day": name_for("#{method}(3i)") }
      ids = { "year": id_for("#{method}_1i"), "month": id_for("#{method}_2i"), "day": id_for("#{method}_3i"),
              "base": id_for(method) }

      tailwind_field(method, label, description: description, width: width, required_asterix: required_asterix) do
        @template.render(DatePickerComponent.new(ids: ids, names: names, value: @object.try(method),
          placeholder: placeholder, disabled: disabled, options: options, start_year: start_year, end_year: end_year, errors: !errors.empty?)) + error(errors.last) + info(info_message)
      end
    end

    def date_field(method, label: nil, description: nil, width: nil, required_asterix: false, info_message: nil)
      errors = object ? object.errors[method] : []

      tailwind_field(method, label, description: description, width: width, required_asterix: required_asterix) do
        @template.render(DateFieldComponent.new(form: self, method: method, value: @object.try(method),
          errors: !errors.empty?)) + error(errors.last) + info(info_message)
      end
    end

    def time_select(method, label: nil, description: nil, width: nil, minute_step: 5, required_asterix: false, info_message: nil)
      input_classes = 'shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm border-gray-300 rounded-md'
      input_error_classes = 'shadow-sm sm:text-sm rounded-md border-red-300 text-red-900 placeholder-red-900 focus:outline-none focus:ring-red-500 focus:border-red-500'

      errors = object ? object.errors[method] : []

      tailwind_field(method, label, description: description, width: width, required_asterix: required_asterix) do
        super(method, { minute_step: minute_step, ignore_date: true }, { class: errors.empty? ? input_classes : input_error_classes }) + error(errors.last) + info(info_message)
      end
    end

    def radio_group(method, label: nil, description: nil, required_asterix: false, info_message: nil, width: :full, columns: :auto, &block)
      raise 'columns parameter must be one of: :auto, :single' unless %i[auto single].include?(columns)

      errors = object ? object.errors[method] : []

      col_class = COL_OPTIONS.fetch(width || :full)

      classes = "flex #{columns == :auto ? 'flex-row' : 'flex-col'} flex-wrap justify-start"

      @template.content_tag :div, class: col_class do
        label(method, label, description: description, required_asterix: required_asterix) + @template.content_tag(:div, class: classes, &block) + error(errors.last) + info(info_message)
      end
    end

    alias orig_radio_button radio_button
    def radio_button(method, value, label, description: nil, required_asterix: false, info_message: nil, can_condition_on: false, options: {})
      errors = object ? object.errors[method] : []

      input_classes = 'form-radio h-5 w-5 my-3 ml-1 mr-2 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 border-gray-400'
      input_error_classes = 'form-radio h-5 w-5 my-3 ml-1 mr-2 shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 border-red-300'

      options.merge!({ 'data-better-conditional-fields-target' => 'source', "data-name": method }) if can_condition_on
      options_with_class = options.merge({ class: errors.empty? ? input_classes : input_error_classes })

      @template.content_tag :div, class: 'flex items-center sm:col-span-6' do
        @template.content_tag(:div, orig_radio_button(method, value, options_with_class),
          class: '') + @template.content_tag(:div,
            label("#{method}_#{value}", label, description: description, required_asterix: required_asterix) + @template.content_tag(:p, info_message, class: 'text-xs text-gray-400'), class: 'pr-10')
      end
    end

    def check_box_group(method, label: nil, description: nil, required_asterix: false, width: :full, info_message: nil, columns: :auto, &block)
      raise 'columns parameter must be one of: :auto, :single' unless %i[auto single].include?(columns)

      errors = object ? object.errors[method] : []

      col_class = COL_OPTIONS.fetch(width || :full)

      classes = "flex #{columns == :auto ? 'flex-row' : 'flex-col'} flex-wrap justify-start"

      @template.content_tag :div, class: col_class do
        label(method, label, description: description, required_asterix: required_asterix) + @template.content_tag(:div, class: classes, &block) + error(errors.last) + info(info_message)
      end
    end

    def check_box(method, value, label, description: nil, width: :full, required_asterix: false, info_message: nil, skip_pr: false, can_condition_on: false, options: {})
      errors = object ? object.errors[method] : []

      input_classes = 'h-5 w-5 my-3 ml-1 mr-2 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 border-gray-400 rounded-md'
      input_error_classes = 'h-5 w-5 my-3 ml-1 mr-2 shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 border-red-300 rounded-md'

      options.merge!({ 'data-better-conditional-fields-target' => 'source', "data-name": method }) if can_condition_on
      options_with_class = options.merge({ class: errors.empty? ? input_classes : input_error_classes })

      col_classes = { full: 'sm:col-span-6', two_thirds: 'sm:col-span-4', half: 'sm:col-span-3',
                      third: 'sm:col-span-2' }
      col_class = col_classes.fetch(width || :full)

      checked_value = value == 'true_false_strings' ? 'true' : value
      unchecked_value = value == 'true_false_strings' ? 'false' : ''

      @template.content_tag :div, class: "flex items-center #{col_class}" do
        # if not checked, the check_box will have {"method" => ""} in the params hash which may need to be cleaned in the controller
        @template.content_tag(:div, super(method, options_with_class, checked_value, unchecked_value), class: '') +
          @template.content_tag(:div, label(method, label, description: description, required_asterix: required_asterix) +
          error(errors.last) + @template.content_tag(:p, info_message, class: 'text-xs text-gray-400'), class: skip_pr ? '' : 'pr-10')
      end
    end

    def icon_select(method, select_options, label: nil, description: nil, width: :full, required_asterix: false, info_message: nil)
      errors = object ? object.errors[method] : []

      tailwind_field(method, label, description: description, width: width, required_asterix: required_asterix) do
        @template.render(IconSelectComponent.new(name_for(method), id_for(method), select_options, value: @object.send(method))) + error(errors.last) + info(info_message)
      end
    end

    def grid(&block)
      @template.content_tag(:div, class: 'grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6', &block)
    end

    def submit(label = 'Save', secondary: false, style: nil, compact: false, **options)
      style ||= secondary ? 'primary-outline' : 'primary-filled'
      button_style = ButtonStyle.find(style)
      options[:class] =
        "inline-flex justify-center #{compact ? 'py-1 px-2' : 'py-2 px-4'} border shadow-sm text-sm font-medium rounded-md #{button_style.link_classes} focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"

      super(label, options)
    end

    alias orig_button button
    def button(label = nil, secondary: false, style: nil, compact: false, name: nil, value: nil, **options, &block)
      if value
        options[:value] = value
        options[:name] = "#{object_name}[#{name || 'commit'}]"
      end

      style ||= secondary ? 'primary-outline' : 'primary-filled'
      button_style = ButtonStyle.find(style)
      options[:class] = "inline-flex justify-center #{compact ? 'py-1 px-2' : 'py-2 px-4'} border shadow-sm text-sm font-medium rounded-md #{button_style.link_classes} focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"

      super(label, options, &block)
    end

    def unstyled_button(label = nil, name: nil, value: nil, **options, &block)
      if value
        options[:value] = value
        options[:name] = "#{object_name}[#{name || 'commit'}]"
      end

      orig_button(label, options, &block)
    end

    def cancel(action, label = 'Cancel', compact: false)
      @template.link_to(label, action, class: "inline-flex justify-center bg-white #{compact ? 'py-1 px-2' : 'py-2 px-4'} border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500")
    end

    def delete(url, label = 'Delete', compact: false)
      @template.link_to(label, url, method: :delete, class: "inline-flex items-center #{compact ? 'py-1 px-2' : 'py-2 px-2'} text-sm font-medium text-red-500 hover:text-red-700 underline")
    end

    def styled_back(label = 'Back', name: nil, value: 'back', **options, &block)
      if value
        options[:value] = value
        options[:name] = "#{object_name}[#{name || 'commit'}]"
      end

      options[:class] = 'inline-flex justify-center text-gray-500 hover:text-gray-700 text-sm font-medium underline'

      orig_button(label, options, &block)
    end

    def styled_cancel(label = 'Cancel', name: nil, value: 'cancel', **options, &block)
      if value
        options[:value] = value
        options[:name] = "#{object_name}[#{name || 'commit'}]"
      end

      options[:class] = 'inline-flex justify-start text-blue-500 hover:text-blue-700 text-sm font-medium underline'

      orig_button(label, options, &block)
    end

    def title(title)
      @template.content_tag(:h1, title, class: 'text-xl leading-6 font-medium text-gray-900 pb-6')
    end

    def section(title = nil, subtitle = nil, border: true, &block)
      heading = title ? section_heading(title, subtitle) : ''.html_safe
      @template.content_tag :div, class: "pb-8 mb-8 #{border && 'border-b border-gray-200'}" do
        heading + @template.content_tag(:div, class: "#{title ? 'mt-6' : ''} grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6", &block)
      end
    end

    def compact_section(title = nil, subtitle = nil, &block)
      heading = title ? section_heading(title, subtitle) : ''.html_safe
      @template.content_tag :div, class: 'pb-1 mb-1' do
        heading + @template.content_tag(:div, class: "#{title ? 'mt-2' : ''} grid grid-cols-1 gap-y-1 gap-x-4 sm:grid-cols-6", &block)
      end
    end

    def button_section(&block)
      @template.content_tag :div do
        @template.content_tag :div, class: 'flex flex-col-reverse space-y-4 space-y-reverse sm:justify-end sm:flex-row sm:space-y-0 sm:space-x-3', &block
      end
    end

    def compact_button_section(&block)
      @template.content_tag :div do
        @template.content_tag :div, class: 'flex flex-col-reverse space-y-4 space-y-reverse sm:justify-end sm:flex-row sm:space-y-0 sm:space-x-3', &block
      end
    end

    def spacer(width:)
      @template.content_tag(:div, class: COL_OPTIONS.fetch(width) { 'sm:col-span-2' }) {}
    end

    def autocomplete_field(method, value_method, text_method, search_params = {}, label: nil, width: nil, disabled: false, selected: :not_specified, list_item_component: nil, required_asterix: false)
      errors = object ? object.errors[method] : []

      # try to look up the selected value if not specified (which allows the caller to explicitly pass in nil to bypass this behaviour)
      if selected == :not_specified
        relation = object.class.try(:reflect_on_all_associations)&.find do |x|
          x.is_a?(ActiveRecord::Reflection::BelongsToReflection) && x.foreign_key.to_s == method.to_s
        end&.name
        selected = relation && object.send(relation)
      end

      col_class = COL_OPTIONS.fetch(width || :full)

      tailwind_field(method, label, width: width, required_asterix: required_asterix) do
        @template.render(AutocompleteComponent.new(
          label: label || method.to_s.humanize,
          field_id: id_for(method),
          field_name: name_for(method),
          value_method: value_method,
          text_method: text_method,
          search_params: search_params,
          object: selected,
          disabled: disabled,
          list_item_component: list_item_component,
          error: !errors.empty?
        )) + error(errors.last)
      end
    end

    def error_summary
      @template.render(FormErrorComponent.new(object))
    end

    private

    def section_heading(title, subtitle = nil)
      @template.content_tag :div do
        if subtitle
          section_title(title) + section_subtitle(subtitle)
        else
          section_title(title)
        end
      end
    end

    def id_for(method, options = {})
      InstanceTag.new(object_name, method, self, options) \
                 .id_for(options)
    end

    def name_for(method, options = {})
      InstanceTag.new(object_name, method, self, options) \
                 .name_for(options)
    end

    def section_title(title)
      @template.content_tag(:h3, title, class: 'text-md leading-6 font-medium text-gray-900')
    end

    def section_subtitle(subtitle)
      @template.content_tag(:p, subtitle, class: 'mt-1 text-sm text-gray-500')
    end

    def tailwind_field(field, label_text = nil, description: nil, width: :full, required_asterix: false, &block)
      # NOTE: need to ensure that the actual strings e.g. sm:col-span-3 appear in the file
      # or tailwind won't include them in the optimized css
      col_class = COL_OPTIONS.fetch(width || :full)
      @template.content_tag :div, class: col_class do
        content = ''
        content << label(field, label_text, description: description, required_asterix: required_asterix) unless label_text == :none
        content << @template.content_tag(:div, class: 'mt-1', &block)
        content.html_safe
      end
    end
  end

  class InstanceTag < ActionView::Helpers::Tags::Base
    def id_for(options)
      add_default_name_and_id(options)
      options['id']
    end

    def name_for(options)
      add_default_name_and_id(options)
      options['name']
    end
  end
end
