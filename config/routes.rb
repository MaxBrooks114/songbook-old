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

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'


  root to: "application#home"
end
