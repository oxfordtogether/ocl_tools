class ApplicationController < ActionController::Base
  # do not import application helper, it will mess up webpack stuff
  helper OclTools::ComponentsHelper

end
