Rails.application.routes.draw do

  root 'listings#index'
  devise_for :users
  
  resources :conversations do
    resources :messages
  end

  resources :listings

  get '/support' => 'support#new'
  post '/support' => 'support#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
