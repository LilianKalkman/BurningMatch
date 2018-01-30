Rails.application.routes.draw do
  root to: "pages#home"

  resources :pages
  resources :users

  devise_for :users

end
