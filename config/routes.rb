# frozen_string_literal: true

Rails.application.routes.draw do
  root "packages#index"

  resources :packages
  get :export_data, to: "export_data#index"
  get :download_csv, to: "export_data#download_csv"
end
