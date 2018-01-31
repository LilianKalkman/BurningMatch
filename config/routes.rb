Rails.application.routes.draw do
  root to: "pages#home"

  resources :pages
  resources :users

  devise_for :users
  resources :users

  get "test" => "pages#test"
  get "test2" => "pages#test2"

  # namespace :api do
  #   resources :users, only: [:update]
  # end

end
