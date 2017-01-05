Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'users#new'

  get '/login', to: 'sessions#new', as: 'login_session'
  post '/session', to: 'sessions#create', as: 'create_session'
  delete '/session', to: 'sessions#destroy', as: 'logout_session'

  get '/user/new', to: 'users#new', as: 'new_user'
  post '/user', to: 'users#create', as: 'create_user'
  get '/user/:id/make_admin', to: 'users#make_admin', as: 'make_admin'
  get '/user/:id/revoke_admin', to: 'users#revoke_admin', as: 'revoke_admin'
  get '/user/:id', to: 'users#show', as: 'show_user'
  get '/users', to: 'users#index', as: 'users'
  delete '/user/:id', to: 'users#destroy', as: 'delete_user'

  get '/stack/new', to: 'stacks#new', as: 'new_stack'
  post '/stack', to: 'stacks#create', as: 'create_stack'
  get '/stack/edit/:id', to: 'stacks#edit', as: 'edit_stack'
  patch '/stack/:id', to: 'stacks#update', as: 'update_stack'
  get '/stack/add_stackers/:id', to: 'stacks#add_stacker', as: 'add_stacker'
  get '/stack/:id', to: 'stacks#show', as: 'show_stack'
  get '/stacks', to: 'stacks#index', as: 'stacks'
  delete '/stack/:id', to: 'stacks#destroy', as: 'delete_stack'
end
