Rails.application.routes.draw do
  resources :flights, only: [:index]
  resources :bookings, only: %i[new create show] do
    get 'search', on: :collection
  end
  root 'flights#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
