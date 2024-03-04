class PlotsController < ApplicationController
  def index
    @plots = Plot.includes(:plants)
  end
end