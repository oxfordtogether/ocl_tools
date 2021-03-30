class ComponentsController < ApplicationController
  def breadcrumbs; end

  def button_link_to; end

  def footer; end

  def notice; end

  def alert; end

  def block_alert; end

  def header; end

  def inbox; end

  def pagination
    @pagy, @items = pagy_array((0..100).to_a)
  end

  def table
    @people = [
      { name: "Alisha", email: "alisha@gmail.com" },
      { name: "Alice", email: "alice@gmail.com" },
    ]
  end
end
