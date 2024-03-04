# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@summerville = Garden.create!(name: "Summerville", organic: true)
@onion = Plant.create!(name: "Onion", description: "Loves to make people cry", days_to_harvest: 10)
@garlic = Plant.create!(name: "Garlic", description: "Wards off vampires", days_to_harvest: 300)
@cherries = Plant.create!(name: "Cherries", description: "Pitless", days_to_harvest: 30)
@eggplant = Plant.create!(name: "Eggplant", description: "Loves strawberries", days_to_harvest: 20)
@watermelon = Plant.create!(name: "Watermelon", description: "Quenches third", days_to_harvest: 10)

@summer_plot_1 = Plot.create!(number: 1, size: "large", direction: "North", garden_id: @summerville.id)
summer_plot_2 = Plot.create!(number: 2, size: "medium", direction: "East", garden_id: @summerville.id)
summer_plot_3 = Plot.create!(number: 3, size: "medium", direction: "West", garden_id: @summerville.id)
summer_plot_4 = Plot.create!(number: 3, size: "small", direction: "West", garden_id: @summerville.id)

plot_1_onion = PlotPlant.create!(plant_id: @onion.id, plot_id: @summer_plot_1.id)
plot_1_garlic = PlotPlant.create!(plant_id: @garlic.id, plot_id: @summer_plot_1.id)
plot_1_cherries = PlotPlant.create!(plant_id: @cherries.id, plot_id: @summer_plot_1.id)
plot_1_eggplant = PlotPlant.create!(plant_id: @eggplant.id, plot_id: @summer_plot_1.id)


plot_2_eggplant = PlotPlant.create!(plant_id: @eggplant.id, plot_id: summer_plot_2.id)
plot_2_watermelon = PlotPlant.create!(plant_id: @watermelon.id, plot_id: summer_plot_2.id)
plot_2_cherries = PlotPlant.create!(plant_id: @cherries.id, plot_id: summer_plot_2.id)

plot_3_cherries = PlotPlant.create!(plant_id: @cherries.id, plot_id: summer_plot_3.id)
plot_3_eggplant = PlotPlant.create!(plant_id: @eggplant.id, plot_id: summer_plot_2.id)

plot_4_garlic = PlotPlant.create!(plant_id: @garlic.id, plot_id: summer_plot_4.id)
plot_4_cherries = PlotPlant.create!(plant_id: @cherries.id, plot_id: summer_plot_4.id)

fallville = Garden.create!(name: "Fallville", organic: false)

fall_plot_1 = Plot.create!(number: 1, size: "small", direction: "North", garden_id: fallville.id)

fall_plot_1_cherries = PlotPlant.create!(plant_id: @cherries.id, plot_id: fall_plot_1.id)
fall_plot_1_eggplant = PlotPlant.create!(plant_id: @eggplant.id, plot_id: fall_plot_1.id)
fall_plot_1_garlic = PlotPlant.create!(plant_id: @garlic.id, plot_id: fall_plot_1.id)
fall_plot_1_watermelon = PlotPlant.create!(plant_id: @watermelon.id, plot_id: fall_plot_1.id)
