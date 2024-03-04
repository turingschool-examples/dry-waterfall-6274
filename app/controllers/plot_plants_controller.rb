class PlotPlantsController < ApplicationController
    def destroy
        @plot = Plot.find(params[:plot_id])
        @plot_plant = @plot.plot_plants.find_by(plant_id: params[:id])

        if @plot_plant
            @plot_plant.destroy 
        end
        
        redirect_to "/plots"
    end
      
end
