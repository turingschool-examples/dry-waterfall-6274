require "rails_helper"

RSpec.describe Plant, type: :model do
  describe 'relationships' do
    it { should have_many(:plot_plants) }
    it { should have_many(:plots).through(:plot_plants)}
  end

  describe "class methods" do
    describe ".unique_plants_under_100_days" do
      before do
        @tomato = Plant.create!(name: "Tomato", description: "Does not like strawberries", days_to_harvest: 100)
        @onion = Plant.create!(name: "Onion", description: "Loves to make people cry", days_to_harvest: 10)
        @garlic = Plant.create!(name: "Garlic", description: "Wards off vampires", days_to_harvest: 300)
        @cherries = Plant.create!(name: "Cherries", description: "Pitless", days_to_harvest: 30)
        @eggplant = Plant.create!(name: "Eggplant", description: "Loves strawberries", days_to_harvest: 20)
        @watermelon = Plant.create!(name: "Watermelon", description: "Quenches third", days_to_harvest: 10)
      end

      it "returns a list of unique plants that take less than 100 days to harvest" do
        expect(Plant.unique_plants_under_100_days.sort).to eq([@onion, @cherries, @eggplant, @watermelon].sort)
      end

      it "orders by 'created_at' descending" do
        cilantro = Plant.create!(name: "Cilantro", description: "Best herb", days_to_harvest: 5)
        expect(Plant.unique_plants_under_100_days).to eq([@onion, @cherries, @eggplant, @watermelon, cilantro])
      end
    end

    describe ".most_popular_plants" do
      before do
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
      end

      it "orders the most popular plants and then by created_at desc" do
        expect(Plant.most_popular_plants).to eq [@cherries, @eggplant, @garlic, @watermelon, @onion]
        summer_plot_5 = Plot.create!(number: 3, size: "small", direction: "West", garden_id: @summerville.id)
        summer_plot_6 = Plot.create!(number: 3, size: "small", direction: "West", garden_id: @summerville.id)
        summer_plot_7 = Plot.create!(number: 3, size: "small", direction: "West", garden_id: @summerville.id)
        PlotPlant.create!(plant_id: @onion.id, plot_id: summer_plot_5.id)
        PlotPlant.create!(plant_id: @onion.id, plot_id: summer_plot_6.id)
        PlotPlant.create!(plant_id: @onion.id, plot_id: summer_plot_7.id)

        expect(Plant.most_popular_plants).to eq([@cherries, @onion, @eggplant, @garlic, @watermelon])

      end

      it "gives access to the number of plants" do
        expect(Plant.most_popular_plants.first.number_of_plants).to eq(5)
        expect(Plant.most_popular_plants.last.number_of_plants).to eq(1)
      end
    end
  end
end
