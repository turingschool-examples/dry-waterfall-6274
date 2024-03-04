Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :gardens, only: [:show] 
  
  resources :plots, only: [:index]

  delete "/plots/:plot_id/plants/:plant_id", to: "plot_plants#destroy"

  

  
end

