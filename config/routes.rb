Rails.application.routes.draw do
  resources :elements
  resources :songs do
    resources :elements, shallow: true
  end


  resources :instruments do
    resources :songs, shallow: true
  end



  resources :users

  end
