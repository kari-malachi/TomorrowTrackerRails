Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'sessions#new'

  get '/login', to: 'sessions#new', as: 'login_session'
  post '/login', to: 'sessions#create', as: 'create_session'
  delete '/logout', to: 'sessions#destroy', as: 'logout_session'

  get '/register', to: 'users#new', as: 'new_user'
  post '/register', to: 'users#create', as: 'create_user'
  get '/user/:id/make_admin', to: 'users#make_admin', as: 'make_admin'
  get '/user/:id/revoke_admin', to: 'users#revoke_admin', as: 'revoke_admin'
  get '/user/:id', to: 'users#show', as: 'show_user'
  get '/users', to: 'users#index', as: 'users'
  delete '/user/:id', to: 'users#destroy', as: 'delete_user'

  get '/stack/new', to: 'stacks#new', as: 'new_stack'
  post '/stack/new', to: 'stacks#create', as: 'create_stack'
  get '/stack/:id/edit', to: 'stacks#edit', as: 'edit_stack'
  patch '/stack/:id', to: 'stacks#update', as: 'update_stack'
  get '/stack/:id', to: 'stacks#show', as: 'show_stack'
  get '/stack/:id/join', to: 'stacks#join', as: 'join_stack'
  get '/stack/:id/leave', to: 'stacks#leave', as: 'leave_stack'
  get '/stack/:id/clue_tree', to: 'stacks#clue_tree', as: 'clue_tree'
  get '/stacks', to: 'stacks#index', as: 'stacks'
  delete '/stack/:id', to: 'stacks#destroy', as: 'delete_stack'

  get '/stack/:stack_id/new_clue', to: 'clues#new', as: 'new_clue'
  post '/stack/:stack_id/new_clue', to: 'clues#create', as: 'create_clue'
  get '/stack/:stack_id/:id/edit', to: 'clues#edit', as: 'edit_clue'
  post '/stack/:stack_id/:id/edit', to: 'clues#update', as: 'update_clue'
  get '/stack/:stack_id/:id', to: 'clues#show', as: 'show_clue'
  delete '/stack/:stack_id/:id', to: 'clues#destroy', as: 'delete_clue'

  get '/stack/:stack_id/:clue_id/new_solution', to: 'solutions#new', as: 'new_solution'
  post '/stack/:stack_id/:clue_id/new_solution', to: 'solutions#create', as: 'create_solution'
  get '/stack/:stack_id/:clue_id/:id', to: 'solutions#edit', as: 'edit_solution'
  post '/stack/:stack_id/:clue_id/:id', to: 'solutions#update', as: 'update_solution'
  delete '/stack/:stack_id/:clue_id/:id', to: 'solutions#destroy', as: 'delete_solution'
end
