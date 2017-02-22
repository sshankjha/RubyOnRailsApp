Rails.application.routes.draw do
  get 'sessions/new'

  resources :accounts
  resources :users
  root  'sessions#new'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  # get '/logout',  to: 'sessions#destroy'
  post '/logout', to: 'sessions#log_out'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
