Rails.application.routes.draw do
  resource :sessions, only: %w[create new destroy]

  namespace :onboardings do
    resource :profile_pictures, only: %w[show update destroy]
    resource :consents, only: %w[edit update destroy]
    resource :bios, only: %w[show update]
    resource :personal_informations, only: %w[show update]
    resource :interests, only: %w[show update destroy]
  end

  resource :onboardings, only: %w[show]

  root "sessions#new"
end
