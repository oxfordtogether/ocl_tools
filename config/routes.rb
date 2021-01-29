OclTools::Engine.routes.draw do
  get '/counter', to: 'counter#index'
  get "/alert", to: 'counter#alert'
end
