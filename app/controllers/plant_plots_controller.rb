class PlantPlotsController < ApplicationController
  def destroy
    PlantPlot.destroy(params[:id])

    redirect_to plots_path
  end
end