class PlantPlotsController < ApplicationController
  def destroy 
    @plot = Plot.find(params[:plot_id])
    @plant = Plant.find(params[:id])
    @plan_plot = PlantPlot.find_by(plant: @plant, plot: @plot)
    @plan_plot.destroy
    redirect_to plots_path
  end
end