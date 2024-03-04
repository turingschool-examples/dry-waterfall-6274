class PlantPlotsController < ApplicationController
    def destroy
        plant_pot = PlantPlot.find(params[:id])
        plant_pot.destroy
        
        redirect_to plots_path
    end

    private

    def plant_pot_params
        params.permit(:id, :plot_id)

    end
end