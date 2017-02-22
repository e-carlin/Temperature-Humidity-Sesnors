class Sensor < ApplicationRecord
	belongs_to :node, :foreign_key => 'network_id', 
	                 :primary_key => 'network_id'
	has_many :readings, :foreign_key => 'pin', 
	                 :primary_key => 'pin'
end
