Rails.application.routes.draw do
  resources :teenagers
  get 'home/index'

  root 'home#index'

  get ':controller(/:action(:id))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
