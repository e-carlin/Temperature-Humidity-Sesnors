class Sensor < ApplicationRecord
	belongs_to :node, :foreign_key => 'node_id', 
	                 :primary_key => 'node_id'
	has_many :readings, :foreign_key => 'pin', 
	                 :primary_key => 'pin'
end
