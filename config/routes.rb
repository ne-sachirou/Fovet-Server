Rails.application.routes.draw do
  resources :users, only: [:create, :destroy]
  namespace :users do
    post :login
  end

  resources :movies, only: [:index, :show, :create, :destroy]
  namespace :movies do
    get :nearby
    get ':id/file' => :file
    post ':id/thumbup' => :thumbup
  end
end
