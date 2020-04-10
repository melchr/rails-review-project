Rails.application.routes.draw do

  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  resources :comments
  resources :reviews
  resources :albums
  resources :users

  root to: "albums#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
