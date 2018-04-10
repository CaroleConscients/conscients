# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en/ do
    root to: 'pages#home'

    resources :products, only: %i[index show]
    get ':id', to: 'high_voltage/pages#show', as: :page, format: false
  end
end
