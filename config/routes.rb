Rails.application.routes.draw do
  devise_for :models
  devise_for :users
  
  resources :wikis
  resources :charges, only: [:new, :create]
  post 'downgrade' => 'charges#downgrade'
  get 'welcome/index'

  get 'welcome/about'
  
  root 'welcome#index'
end
