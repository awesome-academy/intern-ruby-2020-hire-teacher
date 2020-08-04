Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users, only: :omniauth_callbacks,
    controllers: {omniauth_callbacks: "business/omniauth_callbacks"}

  mount Sidekiq::Web, at: "/sidekiq"

  scope "(:locale)", locale: /en|vi/ do
    namespace :business do
      get "/home", to: "static_pages#home"
      get "/about", to: "static_pages#about"
      get "next/:id/:day", to: "calendars#next", as: "next"
      get "prev/:id/:day", to: "calendars#prev", as: "prev"
      resources :rooms, only: %i(index show)
      resources :events, except: :new
      resources :rooms do
        resources :reports, only: %i(create destroy)
      end
    end

    devise_for :users, skip: :omniauth_callbacks, controllers: {
      sessions: "business/sessions",
      registrations: "business/registrations",
      passwords: "business/passwords"
    }

    namespace :managers do
      root to: "homes#index"
      resources :rooms
      resources :events
      resources :room_actives, only: :update
      resources :users
    end

    namespace :trainers do
      root to: "homes#index"
      resources :update_events
    end
  end
end
