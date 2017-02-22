class CreateReadings < ActiveRecord::Migration[5.0]
  def change
  	    create_table :nodes do |t|
    	t.integer :network_id, null: false, :unique => true

      t.timestamps
    end

  	    create_table :sensors do |t|
    	t.integer :pin, null: false, :unique => true
    	t.integer :network_id, null: false #this is a foreign key to a node network_id

      t.timestamps
    end

    create_table :readings do |t|
    	t.integer :pin, null: false #foreign key to sensor pin
    	t.integer :network_id, null: false # F key to node network_id
    	t.integer :temperature, null: false
    	t.integer :humidity, null: false
    	t.datetime :recorded_at, null: false

      t.timestamps
    end
  end
end
