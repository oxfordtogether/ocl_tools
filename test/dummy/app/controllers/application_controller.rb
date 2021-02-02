class ApplicationController < ActionController::Base
  # do not import application helper, it will mess up webpack stuff
  helper OclTools::ComponentsHelper
  helper OclTools::FormHelper
  include Pagy::Backend
  default_form_builder OclTools::TailwindFormBuilder
end
