class GardensController < ApplicationController
    def show
      @garden = Garden.find(params[:id])
      @plants = @garden.plants.harvest_under_100_days
    end
end