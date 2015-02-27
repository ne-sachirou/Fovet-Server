Rails.application.routes.draw do
  resources :users, only: [:create, :destroy]
  namespace :users do
    post :login
  end

  resources :movies, only: [:index, :show, :create, :destroy]
  namespace :movies do
    get :nearby
    get ':uuid/file' => :get_file
    post ':uuid/thumbup' => :thumbup
  end
end
