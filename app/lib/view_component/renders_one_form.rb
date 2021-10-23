module ViewComponent
  module RendersOneForm
    extend ActiveSupport::Concern

    class_methods do
      def renders_one_form(name)
        attr_reader name

        define_method(:render_in) do |view_context, &block|
          old_form_view_context = send(name).instance_variable_get('@template')
          send(name).instance_variable_set('@template', self)
          super(view_context, &block)
        ensure
          send(name).instance_variable_set('@template', old_form_view_context)
        end
      end
    end
  end
end
