class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.uniq_plants
    @hundred_day_plants = @garden.hundred_day_uniq_plants
  end
end