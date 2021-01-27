Rails.application.routes.draw do
  mount OclTools::Engine => "/ocl_tools"

  root to: "pages#home"
end
