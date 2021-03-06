Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/ranking", to: "rankings#index"
  get "/ranking/teams/:ronin_address", to: "rankings#show"

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"

  post "/ronin_address", to: "teams#create", as: :ronin_add

  patch "/ronin_address/:id", to: "teams#update", as: :scholar_name_update
  delete "/ronin_address/:id", to: "teams#destroy", as: :destroy_team

  post '/follower/:id', to: 'followers#new', as: :follower_action
  delete '/follower/:id', to: 'followers#destroy'

  get "/teams/:id", to: "teams#show"

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end


end
