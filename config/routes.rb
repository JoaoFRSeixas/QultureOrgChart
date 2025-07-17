Rails.application.routes.draw do
  resources :companies, only: [:index, :show, :create] do
    resources :employees, only: [:show, :destroy] do
      member do
        put :assign_manager
        get :peers
        get :subordinates
        get :second_level_subordinates
      end
    end
  end
  resources :employees, only: [:show, :destroy]
end
