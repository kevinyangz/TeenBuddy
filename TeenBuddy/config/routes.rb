Rails.application.routes.draw do
  

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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

  devise_for :users, controllers: { registrations: 'users/registrations',
    :omniauth_callbacks => "users/omniauth_callbacks",
    :passwords => "users/passwords" }

devise_scope :user do
  get "users/inactive"=> "users/registrations#inactive", :as => "users_inactive"
  get "users/reset_page"=> "users/passwords#reset_page", :as => "users_reset_page"

end
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
  get  'home/contactus'
  get  'home/privacypolicy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
