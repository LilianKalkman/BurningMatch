Rails.application.routes.draw do
  root to: "pages#home"


  authenticate :user do
    scope "/admin" do
    resources :matches
    end
  end
  resources :matches, only: [:index, :show]
  # resources :pages
  # resources :users

  devise_for :users
  # resources :users

  get "test" => "pages#test"
  get "test2" => "pages#test2"

  get "index" => "users#index"

  # namespace :api do
  #   resources :users, only: [:update]
  # end

end
