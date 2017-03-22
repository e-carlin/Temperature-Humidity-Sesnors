class Reading < ApplicationRecord
	belongs_to :node, :foreign_key => 'node_id', 
	                 :primary_key => 'node_id'
	belongs_to :sensor, :foreign_key => 'pin', 
	                 :primary_key => 'pin'


	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	  	# These are the column attributes taken from the readings schema
	  	# If you want additional attributes on your csv's, add that attribute to the list of columns
	  	columns = ["node_id", "name", "temperature", "humidity", "recorded_at"]
	    csv << columns
	    all.each do |reading|
	      csv << reading.attributes.values_at(*columns)
	    end
	  end
	end
end
