class PlotsController < ApplicationController
  def index
    @plots = Plot.includes(:plants)
  end

  def update
    @plot = Plot.find(params[:plot_id])
    @plant = Plant.find(params[:plant_id])

    @plot.plants.delete(@plant)

    redirect_to plots_path
  end
end