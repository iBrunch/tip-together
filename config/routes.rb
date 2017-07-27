Rails.application.routes.draw do
  devise_for :models
  devise_for :users
  
  resources :wikis
  
  get 'welcome/index'
  
  get 'wikis/index'
  
  get 'welcome/about'
  
  root 'welcome#index'
end
