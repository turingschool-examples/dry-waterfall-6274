class PlotsController < ApplicationController
  def index
    @plots = Plot.all
    @plants = @plots.plants.all
  end
end