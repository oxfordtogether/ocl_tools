class PagesController < ApplicationController
  def home
    redirect_to '/components/form'
  end
end
