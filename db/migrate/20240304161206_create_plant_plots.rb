class CreatePlantPlots < ActiveRecord::Migration[7.1]
  def change
    create_table :plant_plots do |t|
      t.references :plant, null: false, foreign_key: true
      t.references :plot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
