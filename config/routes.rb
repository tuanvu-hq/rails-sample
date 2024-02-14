Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  # Sign Up
  get "/sign-up", to: "registrations#new", as: "new_sign_up"
  post "/sign-up", to: "registrations#create", as: "sign_up"

  # Session
  get "/sign-in", to: "sessions#new", as: "new_sign_in"
  post "/sign-in", to: "sessions#create"
  delete "/sign-out", to: "sessions#destroy", as: "destroy_sign_in"

  # Dashboard
  get "/dashboard", to: "dashboard#index"
  get "/dashboard/notes", to: "dashboard#notes", as: "dashboard_notes"
  get "/dashboard/tags", to: "dashboard#tags", as: "dashboard_tags"
  get "/dashboard/history", to: "dashboard#history", as: "dashboard_history"

  # Notes
  # get "/notes/new", to: "notes#new", as: "new_notes"
  # post "/notes", to: "notes#create"
  # get "/notes/:id/edit", to: "notes#edit", as: "edit_notes"
  # match "/notes/:id", to: "notes#update", via: [:put, :patch]
  # delete "/notes/:id", to: "notes#destroy"
  resources :notes

  # Tags

  # History

  resource :password
end
