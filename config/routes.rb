Rails.application.routes.draw do
  resources :reality_checks
  root 'home#index'
  get 'home/index'
  get 'flic', to: 'reality_checks#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
