Rails.application.routes.draw do
  root 'home#index'

  post '/customers/update' => 'customers#update'

  resources :items
  resources :customers
  resources :owners
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
