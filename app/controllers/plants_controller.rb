class PlantsController < ApplicationController
    def index
        @plants = Plant.all
    end

    def destroy
        @plot = Plot.find(params[:plot_id])
        @plant = Plant.find(params[:id])
        @plot.plants.destroy(@plant)

        redirect_to plots_path notice: 'Plant removed from plot'
    end
end