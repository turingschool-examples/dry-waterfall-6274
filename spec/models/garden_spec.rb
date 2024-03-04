require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  it "#one_hundred_or_less_harvest_days" do
    garden1 = Garden.create(name: "My Garden", organic: true)
    garden2 = Garden.create(name: "Your Garden", organic: false)

    plot1 = Plot.create(number: 1, size: "Small", direction: "North", garden: garden1)
    plot2 = Plot.create(number: 2, size: "Medium", direction: "South", garden: garden1)
    plot3 = Plot.create(number: 3, size: "Large", direction: "East", garden: garden2)

    plant1 = Plant.create(name: "Sunflower", description: "A flower of the sun", days_to_harvest: 50)
    plant2 = Plant.create(name: "Rose", description: "A beautiful flower", days_to_harvest: 80)
    plant3 = Plant.create(name: "Tomato", description: "A juicy fruit", days_to_harvest: 120)

    plot1.plants << plant1
    plot1.plants << plant2
    plot2.plants << plant3

    expect(garden1.one_hundred_or_less_harvest_days.count).to eq(2)
  end
end