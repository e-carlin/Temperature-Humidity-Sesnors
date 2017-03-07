class CreateReadings < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.integer :node_id, null: false, :unique => true #The unique networking id for the node (Assigned in node.ino)
      t.text :name
      t.integer :voltage
      t.datetime :last_reading

      t.timestamps
    end

    create_table :readings do |t|
    	t.integer :node_id, null: false # F key to node.node_id
      t.text :name
    	t.integer :temperature, null: false
    	t.integer :humidity, null: false
    	t.datetime :recorded_at, null: false

      t.timestamps
    end
  end
end
