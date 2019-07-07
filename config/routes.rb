Rails.application.routes.draw do
  resources :elements
  resources :songs
  resources :instruments
  resources :users, shallow: true do
      resources :instruments
      resources :songs
      resources :elements
    end
   end
