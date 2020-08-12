Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    namespace :business do
      get "/home", to: "static_pages#home"
      get "/about", to: "static_pages#about"
      get "/signup", to: "users#new"
      post "/signup", to: "users#create"
      get "/login", to: "sessions#new"
      post "/login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"

      resources :users, except: %i(new create)
      resources :rooms, only: %i(index show)
    end

    namespace :managers do
      root to: "homes#index"
      resources :rooms
    end
  end
end
