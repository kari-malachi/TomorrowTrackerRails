Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'users#new'

  get '/login', to: 'sessions#new', as: 'login_session'
  post '/session', to: 'sessions#create', as: 'create_session'
  delete '/session', to: 'sessions#destroy', as: 'logout_session'

  get '/user/new', to: 'users#new', as: 'new_user'
  post '/user', to: 'users#create', as: 'create_user'
  get '/user/:id', to: 'users#show', as: 'show_user'
  get '/users', to: 'users#index', as: 'users'
  delete '/user/:id', to: 'users#destroy', as: 'delete_user'
end
