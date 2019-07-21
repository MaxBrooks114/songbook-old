Rails.application.routes.draw do

  resources :users do
    resources :elements

    resources :songs do
      resources :elements, shallow: true
    end


    resources :instruments do
      resources :songs, shallow: true
    end

  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get '/auth/google_oauth2/callback', to: 'sessions#googlecreate'
  get 'auth/failure', to: 'application#home'

  root to: "application#home"
end
