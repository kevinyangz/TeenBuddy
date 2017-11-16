Rails.application.routes.draw do
  

  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show, :destroy] do
      member do
    post :reply
    post :restore
  end
    collection do
    delete :empty_trash
  end
  end 
  resources :post_invitations
  resources :post_applications
  devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :posts
  resources :clients do
    resources :client_reviews
  end
  resources :teenagers
  resources :services
  resources :charges

  root 'home#index'
  get  'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
