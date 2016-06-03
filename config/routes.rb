Rails.application.routes.draw do
  root 'welcome#index'

  get '/' => 'welcome#index'

  patch 'welcome/login', to: 'welcome#login'
  get 'welcome/login', to: 'welcome#login'
  get 'welcome/logout', to: 'welcome#logout'
  post 'welcome/logout', to: 'welcome#logout'

  resources :welcome, only: [:index, :create, :login, :logout]
end
