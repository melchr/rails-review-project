Rails.application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#omniauth'
  get 'auth/failure', to: redirect('/')
  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  post '/logout', to: "sessions#destroy"

  resources :albums do
    resources :reviews, except: [:index]
  end
  resources :users, only: [:show, :destroy]
  resources :reviews, only: [:index]

  root to: "albums#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
