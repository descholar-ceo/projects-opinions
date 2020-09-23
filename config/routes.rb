Rails.application.routes.draw do
  resources :comments, only: [:create]
  resources :followings, only: [:create, :destroy]
  resources :opinions, only: [:index, :create]
  devise_for :users, :controllers => { registrations: :registrations }
  resources :users, only: [:show, :index]
  root to: "opinions#index"
end
