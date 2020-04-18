Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index' #get '/'
  resources :manufacturers, only: [:index, :show, :new, :create, :edit, :update]
  resources :subsidiaries, only: [:index, :show, :new, :create]
end
