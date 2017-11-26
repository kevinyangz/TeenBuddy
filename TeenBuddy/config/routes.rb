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

  devise_for :users, controllers: { registrations: 'users/registrations'}


  resources :posts
  resources :clients

  resources :endorsements

  resources :teenagers

  get '/services/invitations', to: 'services#invitations'
  get '/services/applications', to: 'services#applications'

  resources :services




  resources :charges

  root 'home#index'
  get  'home/index'
  get  'home/aboutus'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
