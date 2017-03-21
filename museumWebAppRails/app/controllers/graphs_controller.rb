class GraphsController < ApplicationController
	def show
		#render template: "pages/#{params[:page]}" #TOOD: Do we need this? we don't have a show view...
	end

	def index
		@someValue = "I could be a list, or an int, or anything..."
		@anotherValue = "I'm another value and I can be anything too."
		#We should build the arrays there in the controller and then pass them to the view.
	end

	def numNodes
		return Node.select(:node_id).count
	end
	helper_method :numNodes

	#Gets the past day's readings of both temperature and humidty for a given sensor
	def getData(sensor)

		# We return the data in an array of hashes
		dataInput = []		

		# Query the data
		dataQuery = Reading.select(:recorded_at, :temperature, :humidity).where(node_id: sensor, recorded_at: Date.today.beginning_of_day..Date.today.end_of_day).to_a

		# Format the data appropriately
		# The values have to be stored in array
		tempArray = Array.new
		humArray = Array.new

		# Take values from the queries and put them in tuple
		dataQuery.each do |query|

			newTempReading = [query.recorded_at, query.temperature]
			newHumReading = [query.recorded_at, query.humidity]

			tempArray.push(newTempReading)
			humArray.push(newHumReading)

		end

		# Format the hashes
		tempHash = {}
		humHash = {}

		# Temperature
		tempHash[:name] = "Temperature (F)"
		tempHash[:data] = tempArray

		# Humidity 
		humHash[:name] = "Humidity (%)"
		humHash[:data] = humArray

		# Add the hashes to the data input and return
		dataInput.push(tempHash)
		dataInput.push(humHash)
		return dataInput

	end
	helper_method :getData


	

end


