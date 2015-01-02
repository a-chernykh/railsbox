Rails.application.routes.draw do
  resources :boxes, only: %i(create show edit update) do
    get :download, on: :member
    get :default, on: :collection
  end
  root to: 'dashboard#show'
end
