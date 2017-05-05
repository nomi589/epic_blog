Rails.application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new', as: 'register'

  get '/login', to: 'sessions#new', as: 'login'
  get '/profile', to: 'sessions#show', as: 'profile'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :posts
  get '/posts/:id/confirm_delete', to: 'posts#confirm_delete', as: 'confirm_delete'

  resources :users, only: [:show, :create, :edit, :update]
end
