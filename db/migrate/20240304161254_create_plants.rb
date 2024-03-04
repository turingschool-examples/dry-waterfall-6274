class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :description
      t.integer :days_to_harvest
      t.references :plot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
