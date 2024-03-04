class PlotPlantsController < ApplicationController
  def destroy
    @plant = PlotPlant.find_by(plot_id: params[:plot_id], plant_id: params[:id])
    @plant.destroy

    redirect_to plots_path
  end
end