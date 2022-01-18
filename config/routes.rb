Rails.application.routes.draw do
  root "packages#index"

  resources :packages
end
