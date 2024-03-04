# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


@garden_1 = Garden.create!(name: "Testgarden", organic: true)
@garden_2 = Garden.create!(name: "Test2garden", organic: false)

@plot_1 = Plot.create!(number: 1, size:"small", direction: "east", garden_id: @garden_1.id)
@plot_2 = Plot.create!(number: 2, size:"meduim", direction: "west", garden_id: @garden_2.id)

@plant_1 = Plant.create!(name: "flower", description:"prefers desert", days_to_harvest: 120)
@plant_2 = Plant.create!(name: "grass", description:"prefers water", days_to_harvest: 10)

@plotplant_1 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
@plotplant_2 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_1.id)
@plotplant_3 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_2.id)