Rails.application.routes.draw do
  root to: "pages#home"


  # authenticate :user do
  #   scope "/admin" do
  #   resources :matches
  #   end
  # end
  # resources :matches, only: [:index, :show]
  # resources :pages
  # resources :users

  devise_for :users

  get "test" => "pages#test"
  get "test2" => "pages#test2"
  get "users" => "users#index"
  get "matches" => "matches#index"
  get "mymatches" => "matches#my_matches"
  get "create_new_matches" => "matches#create_new_matches"
  get "unmatch_matches" => "matches#unmatch_matches"

  # get "index" => "users#index"

  # namespace :api do
  #   resources :matches, only: [:create]
  #   resources :users, only: [:update]
  # end

end
