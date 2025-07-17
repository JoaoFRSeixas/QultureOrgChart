Rails.application.routes.draw do
  resources :companies, only: [:index, :show, :create] do
    resources :employees, only: [:index, :create]
  end

  resources :employees, only: [:show, :destroy]
end
