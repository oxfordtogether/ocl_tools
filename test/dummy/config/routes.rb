Rails.application.routes.draw do
  mount OclTools::Engine => "/ocl_tools"

  root to: "pages#home"

  resources :people, only: %i[new create]

  get "/components/breadcrumbs", to: "components#breadcrumbs"
  get "/components/button_link_to", to: "components#button_link_to"
  get "/components/footer", to: "components#footer"
  get "/components/notice", to: "components#notice"
  get "/components/pagination", to: "components#pagination"
  get "/components/table", to: "components#table"
  get "/components/alert", to: "components#alert"
  get "/components/header", to: "components#header"
  get "/components/inbox", to: "components#inbox"
  get "/components/search", to: "components#search"
end
