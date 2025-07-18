Rails.application.routes.draw do
  resources :companies, only: [:index, :show, :create] do
    resources :employees, only: [:index, :create]
  end
  resources :employees, only: [:show, :update, :destroy]

  resources :employees, only: [:show, :destroy] do
    member do
      put :assign_manager
      get :peers
      get :subordinates
      get :second_level_subordinates
    end
  end
end
