class PlotPlantsController < ApplicationController
  def destroy
    plot_plant = PlotPlant.find(params[:id]).destroy
    redirect_to "/plots"
  end
end