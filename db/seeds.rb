# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@garden = Garden.create!(name: "Larry's Garden", organic: true)

@plot_1 = @garden.plots.create(number: 1, size: "large", direction: "west")
@plot_2 = @garden.plots.create(number: 2, size: "small", direction: "east")

@plant_1 = Plant.create!(name: "Rose", description: "red", days_to_harvest: 5)
@plant_2 = Plant.create!(name: "Sunflower", description: "red", days_to_harvest: 115)

PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_1.id)
PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_2.id)
PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_2.id)