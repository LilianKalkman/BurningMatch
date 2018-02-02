Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  get "test" => "pages#test"
  get "test2" => "pages#test2"

  get "matches" => "matches#index"
  get "mymatches" => "matches#my_matches"
  get "create_new_matches" => "matches#make_matches"
  get "unmatch_matches" => "matches#remove_matches"
  get "match_stats" => "matches#match_stats"

  get "users" => "users#index"
  get "toggle_admin" => "users#toggle_admin"


  # namespace :api do
  #   resources :matches #, only: [:create]
  #   resources :users #, only: [:update]
  # end

end
