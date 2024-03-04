require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe "validation" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :organic }
  end

  let!(:garden) { Garden.create!(name: "Turing Community Garden", organic: true) }
  let!(:plot_1) { garden.plots.create!(number: 1, size: "Large", direction: "East") }
  let!(:plot_2) { garden.plots.create!(number: 2, size: "Small", direction: "West") }

  let!(:plant_1) { Plant.create!(name: "Rose", description: "Flower", days_to_harvest: 120) }
  let!(:plant_2) { Plant.create!(name: "Broccoli", description: "Vegetable", days_to_harvest: 55) }
  let!(:plant_3) { Plant.create!(name: "Lily", description: "Flower/ Bulb", days_to_harvest: 30) }

  let!(:plant_plot_1) { PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_1.id) }
  let!(:plant_plot_2) { PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_3.id) }
  let!(:plant_plot_3) { PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_2.id) }
  let!(:plant_plot_4) { PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_3.id) }

  describe "#plants_harvest_under_100_days" do
    it "returns the plants that can harvest less than 100 days" do
      expect(garden.plants_harvest_under_100_days).to eq([plant_2,plant_3])
    end
  end
end
