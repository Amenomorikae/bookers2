Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books
  resources :users
  resources :booktop, only: [:top]
  get "home/about", to: 'booktop#index'
  root :to => 'booktop#top'
  resources :books, only: [:new, :create, :index, :show, :destroy] do
  end
    resources :users, only: [:show, :edit, :create, :update]
end
