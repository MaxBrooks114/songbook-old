Rails.application.routes.draw do
  resources :elements
  resources :songs

  resources :instruments do
    resources :songs, shallow: true
  end

  resources :users, shallow: true do
      resources :instruments
      resources :songs
      resources :elements
    end
   end
