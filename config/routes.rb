Rails.application.routes.draw do
  get 'collaborators/new'
  
  devise_for :models
  devise_for :users

scope do
  resources :wikis, path: 'tips'
end

  resources :charges, only: [:new, :create]
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end
  post 'downgrade' => 'charges#downgrade'
  get 'welcome/index'
  get 'welcome/about'
  root 'welcome#index'
end

