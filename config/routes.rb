Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :plots, only: [:index] 
  
  delete "/plots/:plot_id/plants/:id", to: "plant_plots#destroy"

  resources :gardens, only: [:show]
end
