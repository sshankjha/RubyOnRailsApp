Rails.application.routes.draw do
  resources :transactions
  get 'sessions/new'
  get '/friends/:id', to: 'users#show_friends', as: 'friends'
  post '/friends/:id', to: 'users#add_friends', as: 'add_friends'
  get 'admin/:id', to: 'admin#show', as: 'admin'
  get '/admin/new', to: 'admin#new', as: 'new_admin'
  post '/admin', to: 'admin#create', as: 'admins'
  get '/view_admins', to:'admin#view_admins', as: 'view_admins'
  get '/view_users', to:'admin#view_users', as:'view_users'
  resources :accounts
  resources :users
  get '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/show_accounts', to: 'admin#show_accounts', as: 'show_accounts'
  post '/act_account/:id', to: 'admin#state_change_account', as:'change_state_account'
  root 'sessions#new'
  get '/view_trans/:id', to:'accounts#view_trans', as: 'view_trans'
  get '/showtrans/:id', to: 'users#show_trans', as: 'show_trans'
  get '/show_pending_t', to: 'admin#show_ptrans', as: 'show_ptrans'
  post '/manage_trans/:id', to: 'admin#manage_transaction', as: 'manage_trans'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#log_out'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
