Rails.application.routes.draw do
  resources :users, only: [:create, :destroy]
  namespace :users do
    post :login
    post :logout
  end

  resources :movies, only: [:index, :show, :create, :destroy]
  namespace :movies do
    post ':id/thumbup' => :thumbup
  end
end
