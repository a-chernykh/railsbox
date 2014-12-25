Rails.application.routes.draw do
  resources :configurations, only: %i(create)
  root to: 'dashboard#show'
end
