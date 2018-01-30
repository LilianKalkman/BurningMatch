Rails.application.routes.draw do

  root to: "pages#home"
  devise_for :users
  resources :users

  # namespace :api do
  #   resources :users, only: [:update]
  # end

end
