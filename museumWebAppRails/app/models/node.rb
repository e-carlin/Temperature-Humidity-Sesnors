class Node < ApplicationRecord
	has_many :sensors, :foreign_key => 'network_id', 
	                 :primary_key => 'network_id'
	has_many :readings, :foreign_key => 'network_id', 
	                 :primary_key => 'network_id'
end
