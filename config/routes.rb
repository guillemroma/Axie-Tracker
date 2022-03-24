Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/ranking", to: "rankings#index"

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"

  post "/ronin_address", to: "teams#create", as: :ronin_add

  patch "/ronin_address/:id", to: "teams#update", as: :scholar_name_update
  delete "/ronin_address/:id", to: "teams#destroy", as: :destroy_account

  post '/follower/:id', to: 'followers#new', as: :new_follower
  delete '/follower/:id', to: 'followers#destroy', as: :destroy_follower

end
