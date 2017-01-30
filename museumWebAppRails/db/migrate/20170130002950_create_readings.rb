class CreateReadings < ActiveRecord::Migration[5.0]
  def change
    create_table :readings do |t|
    	t.integer :temperature, null: false
    	t.integer :humidity, null: false

      t.timestamps
    end
  end
end
