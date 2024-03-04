# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@garden_1 = Garden.create!(name: "The best garden", organic: true)
@garden_2 = Garden.create!(name: "The worst garden", organic: false)

@plot_1 = @garden_1.plots.create!(number: 10, size: "100 acres", direction: "North")
@plot_2 = @garden_2.plots.create!(number: 5, size: "1 acre", direction: "South")

@plant_1 = Plant.create!(name: "Lily's", description: "Bright Yellow", days_to_harvest: 25)
@plant_2 = Plant.create!(name: "Sun Flower", description: "Barely Alive", days_to_harvest: 40)

PlantPlot.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
PlantPlot.create!(plant_id: @plant_2.id, plot_id: @plot_2.id)
PlantPlot.create!(plant_id: @plant_1.id, plot_id: @plot_2.id)