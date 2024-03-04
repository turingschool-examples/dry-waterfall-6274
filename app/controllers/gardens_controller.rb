class GardensController < ApplicationController

    def show
        @garden = Garden.find(params[:id])
        @plants = @garden.distinct_plants
        
    end
end