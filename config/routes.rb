Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"

  post "/ronin_address", to: "teams#create", as: :ronin_add

  patch "/ronin_address/:id", to: "teams#update", as: :scholar_name_update
  delete "/ronin_address/:id", to: "teams#destroy", as: :destroy_account



end
