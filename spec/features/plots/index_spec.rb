require "rails_helper"

RSpec.describe "Plots index page" do
  before do
    @garden_1 = Garden.create!(name: "Barry's Garden", organic: true)

    @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "North")
    @plot_2 = @garden_1.plots.create!(number: 2, size: "Medium", direction: "South")
    @plot_3 = @garden_1.plots.create!(number: 3, size: "Small", direction: "East")
    @plot_4 = @garden_1.plots.create!(number: 4, size: "Medium", direction: "West")
    @plot_5 = @garden_1.plots.create!(number: 5, size: "Large", direction: "North")

    @wheat = Plant.create!(name: "Wheat", description: "Standard sun and water requirements for wheat", days_to_harvest: 90)
    @spinach = Plant.create!(name: "Spinach", description: "Standard sun and water requirements for spinach", days_to_harvest: 60)
    @broccoli = Plant.create!(name: "Broccoli", description: "Standard sun and water requirements for broccoli", days_to_harvest: 50)
    @tomato = Plant.create!(name: "Tomato", description: "Standard sun and water requirements for tomatoes", days_to_harvest: 30)
    @carrot = Plant.create!(name: "Carrot", description: "Standard sun and water requirements for carrots", days_to_harvest: 90)
    @eggplant = Plant.create!(name: "Eggplant", description: "Standard sun and water requirements for eggplants", days_to_harvest: 60)

    PlotPlant.create!(plot: @plot_1, plant: @wheat)
    PlotPlant.create!(plot: @plot_1, plant: @spinach)
    PlotPlant.create!(plot: @plot_1, plant: @tomato)
    PlotPlant.create!(plot: @plot_1, plant: @carrot)
    PlotPlant.create!(plot: @plot_1, plant: @eggplant)

    PlotPlant.create!(plot: @plot_2, plant: @spinach)
    PlotPlant.create!(plot: @plot_2, plant: @carrot)
    PlotPlant.create!(plot: @plot_2, plant: @eggplant)

    PlotPlant.create!(plot: @plot_3, plant: @wheat)
    PlotPlant.create!(plot: @plot_3, plant: @tomato)

    PlotPlant.create!(plot: @plot_4, plant: @broccoli)
    PlotPlant.create!(plot: @plot_4, plant: @wheat)

    PlotPlant.create!(plot: @plot_5, plant: @wheat)
    PlotPlant.create!(plot: @plot_5, plant: @carrot)
    PlotPlant.create!(plot: @plot_5, plant: @eggplant)
  end

  
  it "has a list of all plot numbers" do
    visit plots_path

    expect(page).to have_content("Plot Number: 1")
    expect(page).to have_content("Plot Number: 2")
    expect(page).to have_content("Plot Number: 3")
    expect(page).to have_content("Plot Number: 4")
    expect(page).to have_content("Plot Number: 5")
  end

  describe "User Story 1 - Plots Index Page" do
    it "has all plants belonging to each plot number" do
      visit plots_path

      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content("Wheat")
        expect(page).to have_content("Spinach")
        expect(page).to have_content("Tomato")
        expect(page).to have_content("Carrot")
        expect(page).to have_content("Eggplant")
        expect(page).to_not have_content("Broccoli")
      end

      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content("Spinach")
        expect(page).to have_content("Eggplant")
        expect(page).to have_content("Carrot")
        expect(page).to_not have_content("Tomato")
        expect(page).to_not have_content("Wheat")
        expect(page).to_not have_content("Broccoli")
      end

      within("#plot-#{@plot_3.id}") do
        expect(page).to have_content("Wheat")
        expect(page).to have_content("Tomato")
        expect(page).to_not have_content("Spinach")
        expect(page).to_not have_content("Carrot")
        expect(page).to_not have_content("Eggplant")
        expect(page).to_not have_content("Broccoli")
      end

      within("#plot-#{@plot_4.id}") do
        expect(page).to have_content("Wheat")
        expect(page).to have_content("Broccoli")
        expect(page).to_not have_content("Spinach")
        expect(page).to_not have_content("Tomato")
        expect(page).to_not have_content("Carrot")
        expect(page).to_not have_content("Eggplant")
      end

      within("#plot-#{@plot_5.id}") do
        expect(page).to have_content("Wheat")
        expect(page).to have_content("Carrot")
        expect(page).to have_content("Eggplant")
        expect(page).to_not have_content("Spinach")
        expect(page).to_not have_content("Tomato")
        expect(page).to_not have_content("Broccoli")
      end
    end
  end

  describe "User Story 2 - Remove a Plant from a Plot" do
    it "can remove plants from a plot" do
      visit plots_path
  
      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content("Wheat")
        within("#plot-#{@plot_1.id}-plant-#{@wheat.id}") do
          click_button("Remove Plant From Plot")
        end
        expect(page).to have_content("Spinach")
        within("#plot-#{@plot_1.id}-plant-#{@spinach.id}") do
          click_button("Remove Plant From Plot")
        end
      end
  
      expect(current_path).to eq(plots_path)
  
      within("#plot-#{@plot_1.id}") do
        expect(page).to_not have_content("Wheat")
        expect(page).to_not have_content("Spinach")
      end
  
      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content("Spinach")
      end
  
      within("#plot-#{@plot_3.id}") do
        expect(page).to have_content("Wheat")
      end
  
      within("#plot-#{@plot_4.id}") do
        expect(page).to have_content("Wheat")
      end
  
      within("#plot-#{@plot_5.id}") do
        expect(page).to have_content("Wheat")
      end
    end
  end
end