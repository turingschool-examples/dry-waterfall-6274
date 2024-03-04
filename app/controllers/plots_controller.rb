class PlotsController < ApplicationController
    def index
      @plots = Plot.includes(:plants).all # to retrieve all plots data and the plants associated to them
    end
end