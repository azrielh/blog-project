Rails.application.routes.draw do

  devise_for :users

  resources :posts do

    resources :comments, only: [:create, :destroy, :edit, :update]
    resources :likes, only: [:create, :destroy]
    resources :favourites, only: [:create, :destroy]

  end

  root "posts#index"

  resources :favourites, only: [:index]

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]


end
