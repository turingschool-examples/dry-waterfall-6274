class PlotPlantsController < ApplicationController
  def destroy
    @plotplant = PlotPlant.find_by(plot_id: params[:plot_id], plant_id: params[:id])
    @plotplant.destroy
    redirect_to '/plots'
  end
end