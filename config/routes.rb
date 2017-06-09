Rails.application.routes.draw do
  devise_for :models
  devise_for :users
  get 'welcome/index'

  get 'welcome/about'
  
  root 'welcome#index'
end
