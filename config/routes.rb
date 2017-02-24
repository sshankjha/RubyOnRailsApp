Rails.application.routes.draw do
  get 'sessions/new'
  get 'friends/:id', to: 'users#show_friends', as: 'friends'
  post 'friends/:id', to: 'users#add_friends', as: 'add_friends'
  get 'admin/:id', to: 'admin#show', as: 'admin'
  resources :accounts
  resources :users
  get '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  root 'sessions#new'
  get '/viewtrans/:id', to:'accounts#view_trans', as: 'view_trans'
  get '/showtrans/:id', to: 'users#show_trans', as: 'show_trans'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#log_out'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
