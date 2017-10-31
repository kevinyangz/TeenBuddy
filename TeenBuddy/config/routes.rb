Rails.application.routes.draw do
  resources :post_invitations
  resources :post_applications
  devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :posts
  resources :clients
  resources :teenagers
  resources :services

  root 'home#index'
  get  'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
