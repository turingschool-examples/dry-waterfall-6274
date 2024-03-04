class AddPlotToPlants < ActiveRecord::Migration[7.1]
  def change
    add_reference :plants, :plot, null: false, foreign_key: true
  end
end
