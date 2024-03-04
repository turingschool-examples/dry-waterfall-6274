require 'rails_helper'

RSpec.describe 'Garden Show page' do
  it 'has a unique list of plants in the garden plots' do
    garden1 = Garden.create(name: "My Garden", organic: true)

    plot1 = Plot.create(number: 1, size: "Small", direction: "North", garden: garden1)
    plot2 = Plot.create(number: 2, size: "Medium", direction: "South", garden: garden1)
  
    plant1 = Plant.create(name: "Sunflower", description: "A flower of the sun", days_to_harvest: 50)
    plant2 = Plant.create(name: "Rose", description: "A beautiful flower", days_to_harvest: 180)
    plant3 = Plant.create(name: "Tomato", description: "A juicy fruit", days_to_harvest: 80)
    plant4 = Plant.create(name: "Tomato", description: "Another juicy fruit", days_to_harvest: 800)

    plot1.plants << plant1
    plot1.plants << plant2
    plot2.plants << plant3

    visit "/gardens/#{garden1.id}"

    expect(page).to_not have_content(plant2.name)
    expect(page).to_not have_content(plant4.name)
    expect(page).to have_content(plant3.name)
    expect(page).to have_content(plant1.name)
  end

  it 'has plants that only have less than 100 days to harvest' do
    garden1 = Garden.create(name: "My Garden", organic: true)

    plot1 = Plot.create(number: 1, size: "Small", direction: "North", garden: garden1)
    plot2 = Plot.create(number: 2, size: "Medium", direction: "South", garden: garden1)
  
    plant1 = Plant.create(name: "Sunflower", description: "A flower of the sun", days_to_harvest: 50)
    plant2 = Plant.create(name: "Rose", description: "A beautiful flower", days_to_harvest: 180)
    plant3 = Plant.create(name: "Tomato", description: "A juicy fruit", days_to_harvest: 80)
    plant4 = Plant.create(name: "Tomato", description: "Another juicy fruit", days_to_harvest: 800)
  
    plot1.plants << plant1
    plot1.plants << plant2
    plot2.plants << plant3

    visit "/gardens/#{garden.id}"

    expect(page).to_not have_content(plant2.name) # 180
    expect(page).to_not have_content(plant4.name) # 800
    expect(page).to have_content(plant3.name) #80
    expect(page).to have_content(plant1.name) # 50
  end
end