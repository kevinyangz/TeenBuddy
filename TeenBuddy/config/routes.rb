Rails.application.routes.draw do
  resources :posts
  resources :clients
  resources :teenagers

  root 'posts#index'
  get  'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
