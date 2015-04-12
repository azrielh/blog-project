Rails.application.routes.draw do

  devise_for :users

  resources :posts do

    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :favourites, only: [:create, :destroy]

  end

  root "posts#index"

  resources :favourites, only: [:index]


end
