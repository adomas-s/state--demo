Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :games, only: %i(new create show index) do
    resources :attempts, only: %i(create)
  end
  resources :sessions, only: %i(new create destroy)

  root "games#index"
end
