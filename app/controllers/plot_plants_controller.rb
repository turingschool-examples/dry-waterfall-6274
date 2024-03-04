class PlotPlantsController < ApplicationController
    
    def destroy
        
        plot = Plot.find(params[:plot_id])
        plant = Plant.find(params[:plant_id])
        plotplant = PlotPlant.where(plant_id: plant.id, plot_id: plot.id).first
        plotplant.destroy
        redirect_to "/plots"
        
    end
end