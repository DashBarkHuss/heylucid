Rails.application.routes.draw do
  resources :users do
	  resources :reality_checks
  end
  root 'home#index'
  get 'home/index'
  # get 'flic', to: 'reality_checks#create'
  # 
  get 'log_in' => 'sessions#new', as: 'login'
  get 'log_out' => 'sessions#destroy', as: 'logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
