class ComponentsController < ApplicationController
  def autocomplete; end

  def breadcrumbs; end

  def button_link_to; end

  def date_field; end

  def date_picker; end

  def file_upload; end

  def footer; end

  def form_error; end

  def notice; end

  def pagination
    @pagy, @items   = pagy_array((0..100).to_a)
  end

  def table
    @people = [
      {name: "Alisha", email: "alisha@gmail.com"},
      {name: "Alice", email: "alice@gmail.com"},
    ]
  end
end
