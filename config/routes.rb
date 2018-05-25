Rails.application.routes.draw do
  resources :users do
    resources :reality_checks
  end
  get 'home/landing_page'
  # get 'flic', to: 'reality_checks#create'

  get 'log_in' => 'sessions#new', as: 'login'
  post 'log_in' => 'sessions#create'
  get 'log_out' => 'sessions#destroy', as: 'logout'
  get 'users/:id/dashboard' => 'users#dashboard', as: 'dashboard'

  root 'users#show'
end
