Rails.application.routes.draw do
  mount OclTools::Engine => '/ocl_tools'

  root to: "pages#home"

  get '/components/autocomplete', to: 'components#autocomplete'
  get '/components/breadcrumbs', to: 'components#breadcrumbs'
  get '/components/button_link_to', to: 'components#button_link_to'
  get '/components/date_field', to: 'components#date_field'
  get '/components/date_picker', to: 'components#date_picker'
  get '/components/file_upload', to: 'components#file_upload'
  get '/components/footer', to: 'components#footer'
  get '/components/form_error', to: 'components#form_error'
  get '/components/notice', to: 'components#notice'
  get '/components/pagination', to: 'components#pagination'
  get '/components/table', to: 'components#table'
end
