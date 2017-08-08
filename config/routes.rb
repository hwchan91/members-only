Rails.application.routes.draw do
  root 'sessions#new'
  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  delete  '/logout', to: 'sessions#delete'
  resources :posts,     only: [:new, :create, :index]
  resources :users, only: [:new, :create]
end
