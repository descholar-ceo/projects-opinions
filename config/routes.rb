Rails.application.routes.draw do
  root to: "opinions#index"
  resources :comments, only: [:create]
  resources :followings, only: [:create, :destroy]
  resources :opinions, only: [:index, :create]
  devise_for :users, :controllers => { registrations: :registrations }
  resources :users, only: [:show, :index]
end
