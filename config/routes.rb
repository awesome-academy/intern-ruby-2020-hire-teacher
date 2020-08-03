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
      get "next/:id/:day", to: "calendars#next", as: "next"
      get "prev/:id/:day", to: "calendars#prev", as: "prev"
      get "history/:id", to: "history#show", as: "history"

      resources :users, except: %i(new create)
      resources :rooms
      resources :events, except: :new
    end

    namespace :managers do
      root to: "homes#index"
      resources :rooms
    end
  end
end
