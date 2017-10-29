Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :posts
  resources :clients
  resources :teenagers
  resources :services

  root 'home#index'
  get  'home/index'
  get  'home/header'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
