class PlotPlantsController < ApplicationController
  def destroy
    plotplant = PlotPlant.find_by(
      plant_id: params[:id], 
      plot_id: params[:plot_id])
    plotplant.destroy
    redirect_to plots_path
  end
end