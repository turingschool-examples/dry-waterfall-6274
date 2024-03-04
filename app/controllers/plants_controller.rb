class PlantsController < ApplicationController
  def destroy
    plot = Plot.find(params[:plot_id])
    plant_plot = plot.plant_plots.find_by(plant_id: params[:id])
    plant_plot.destroy if plant_plot

    redirect_to plots_path
  end
end
