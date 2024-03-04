class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plots = @garden.plots
    @plants = @plots.plants.distinct
    @unique_plants = @plants.one_hundred_or_less_harvest_days
  end
end