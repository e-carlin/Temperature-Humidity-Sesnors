class Reading < ApplicationRecord
	belongs_to :node, :foreign_key => 'network_id', 
	                 :primary_key => 'network_id'
	belongs_to :sensor, :foreign_key => 'pin', 
	                 :primary_key => 'pin'


	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |reading|
	      csv << reading.attributes.values_at(*column_names)
	    end
	  end
	end
end
