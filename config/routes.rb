Rails.application.routes.draw do
  resources :boxes, only: %i(create show) do
    get :download, on: :member
  end
  root to: 'dashboard#show'
end
