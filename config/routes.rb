Rails.application.routes.draw do
  resources :comments
  resources :followings
  resources :opinions
  devise_for :users
  resources :users, only: [:show,:index]
  root to: "opinions#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
