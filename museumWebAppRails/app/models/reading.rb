class Reading < ApplicationRecord
	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |reading|
	      csv << reading.attributes.values_at(*column_names)
	    end
	  end
	end
end
