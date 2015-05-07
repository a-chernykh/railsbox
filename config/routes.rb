Rails.application.routes.draw do
  resources :boxes, only: %i(create show edit update destroy) do
    get :download, on: :member
    get :default, on: :collection
  end

  post 'configurations/for_gemfile'

  root to: 'dashboard#show'
end
