Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :peoples, only: [] do
    post :upload, on: :collection
  end
  resources :buildings, only: [] do
    post :upload, on: :collection
  end
end
