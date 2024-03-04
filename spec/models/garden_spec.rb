require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe '#plants_with_short_harvest_time' do
    it 'returns plants with harvest time less than 100 days' do
        garden1 = Garden.create!(name: "West Asheville OG", organic: true)
        plot1 = garden1.plots.create!(number: 1, size: "Large", direction: "East")
        plot2 = garden1.plots.create!(number: 2, size: "Large", direction: "West")
        plot3 = garden1.plots.create!(number: 3, size: "Medium", direction: "North")
        avo = plot1.plants.create!(name: "Dwarf avocado", description: "Small and yummy tree", days_to_harvest: 365)
        tomato = plot1.plants.create!(name: "Heirloom Tomato", description: "juicy AF", days_to_harvest: 45)
        spinach = plot2.plants.create!(name: "Spinach", description: "green is good", days_to_harvest: 30)
        arugula = plot2.plants.create!(name: "Arugula", description: "mixed greens are good", days_to_harvest: 28)
        strawberries = plot3.plants.create!(name: "Strawberries", description: "good to have fruit too", days_to_harvest: 33)
        blueberries = plot3.plants.create!(name: "Blueberries", description: "good for the belly", days_to_harvest: 40)

        result = garden1.plants_with_short_harvest_time

        expect(result).to include(tomato)
        expect(result).to include(spinach)
        expect(result).to include(arugula)
        expect(result).to include(strawberries)
        expect(result).to include(blueberries)
        expect(result).not_to include(avo)
    end
  end
end