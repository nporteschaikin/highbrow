require "sidekiq/web"

Rails.application.routes.draw do
  root to: "home#show"

  get "sessions/new", to: "sessions#new"
  get "sessions/callback", to: "sessions#callback"

  mount Sidekiq::Web => '/sidekiq'
end
