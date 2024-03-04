class AddPlantToPlots < ActiveRecord::Migration[7.1]
  def change
    add_reference :plots, :plant, null: false, foreign_key: true
  end
end
