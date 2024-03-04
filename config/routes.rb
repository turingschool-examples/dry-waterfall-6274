Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/plots', to: 'plots#index'

  delete '/plot_plants/:plot_id/:plant_id', to: 'plot_plants#destroy'
end
