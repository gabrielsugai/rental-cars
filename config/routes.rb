Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index' #get '/'
  resources :manufacturers
  resources :subsidiaries, only: [:index, :show, :new, :create]
  resources :car_categories, only: [:index, :show, :new, :create]
  resources :car_models, only: [:index, :show, :new, :create]
  resources :customers, only: [:index] do
    get 'search', on: :collection
  end
  resources :rentals, only: [:index, :new, :create] do
    get 'search', on: :collection
  end
end
