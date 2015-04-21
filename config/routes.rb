Rails.application.routes.draw do

  namespace :admin do
    resources :users
  end

  root "posts#index"

  devise_for :users

  resources :posts do

    resources :comments, only: [:create, :destroy, :edit, :update]
    resources :likes, only: [:create, :destroy]
    resources :favourites, only: [:create, :destroy]

  end

  resources :favourites, only: [:index]

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  get 'tags/:tag', to: 'posts#index', as: :tag

end
