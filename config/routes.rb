Rails.application.routes.draw do

  get '/' => 'welcome#index'

  root 'welcome#index'
  patch 'welcome/login', to: 'welcome#login'
  resources :welcome, only: [:index, :create, :login, :logout]
end
