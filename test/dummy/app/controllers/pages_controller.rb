class PagesController < ApplicationController
  def home
    redirect_to '/people/new'
  end
end
