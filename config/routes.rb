Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  get "matches" => "matches#index"
  get "mymatches" => "matches#my_matches"
  get "create_new_matches" => "matches#make_matches"
  get "unmatch_matches" => "matches#remove_matches"
  get "match_stats" => "matches#match_stats"

  get "users" => "users#index"
  get "toggle_admin" => "users#toggle_admin"

end
