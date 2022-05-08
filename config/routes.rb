Rails.application.routes.draw do
  resource :sessions, only: %w[create new destroy]
  namespace :onboardings do
    resource :consents, only: %w[edit update destroy]
  end

  root "sessions#new"
end
