Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :user 

  get '/login', to: 'sessions#login', as: 'login_session'
  post '/sessions/login_attempt', to: 'sessions#login_attempt', as: 'login_attempt_session'
end
