Rails.application.routes.draw do
  root to: "pages#home"

  resources :pages
  resources :users

  devise_for :users
  resources :users

  # Add next line
  get "test" => "pages#test"

  # namespace :api do
  #   resources :users, only: [:update]
  # end

end
