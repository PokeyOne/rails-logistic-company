Rails.application.routes.draw do
  root "packages#index"

  get "/packages", to: "packages#index"
  get "/packages/:id", to: "packages#show"
end
