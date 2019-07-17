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

  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  root to: "application#home"
end
