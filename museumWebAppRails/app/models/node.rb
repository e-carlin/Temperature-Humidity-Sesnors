class Node < ApplicationRecord
	has_many :sensors, :foreign_key => 'node_id', 
	                 :primary_key => 'node_id'
	has_many :readings, :foreign_key => 'node_id', 
	                 :primary_key => 'node_id'
end
