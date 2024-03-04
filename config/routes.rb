Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :plots, only: :index do
    resources :plants, controller: 'plot_plants'
  end

  resources :gardens, only: :show
end
