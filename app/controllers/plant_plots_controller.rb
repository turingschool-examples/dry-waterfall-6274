class PlantPlotsController < ApplicationController
 def destroy
  plant_plot = PlantPlot.find_by(plot_id: params[:plot_id], plant_id: params[:id])
  plant_plot.destroy if plant_plot
  redirect_to plots_path
 end
end