class GraphsController < ApplicationController
	def show
		#render template: "pages/#{params[:page]}" #TOOD: Do we need this? we don't have a show view...
	end

	def index
		@someValue = "I could be a list, or an int, or anything..."
		@anotherValue = "I'm another value and I can be anything too."
		#We should build the arrays there in the controller and then pass them to the view.
	end

	# Parameters we need
	# compareTempAndHum: Are we only comparing temperature and humidity for one sensor?
	# measurement: Is it temperature, or humidity?
	# allSensors: Do we want data from every single sensor?
	# selectSensors: Which specific sensors do we want data from?
	# startDate: What is the start date of measurement?
	# endDate: What is the end date of measurement?
	def getData(compareTempAndHum, measurement, allSensors, selectSensors, startDate, endDate)

		#Get temperature and humidity from only one sensor
		if compareTempAndHum == true 	

			# We assume the first entry is the sensor of interest
			sensor = selectSensors[0]	

			# Query the data we want
			dataQuery = Reading.select(:recorded_at, :temperature, :humidity).where(node_id: sensor, recorded_at: startDate.beginning_of_day..endDate.end_of_day).to_a

			# Format data for chart
			dataInput = []

			# Add temperature data series
			tempHash = {}
			# Name
			tempHash[:temp] = "Temperature"
			# Data
			tempArray = Array.new
			dataQuery.each do |tuple|

				newReading = [tuple.recorded_at, tuple.temperature]
				tempArray.push(newReading)

			end
			tempHash[:data] = tempArray

			# Add Humidity data series
			humHash = {}
			# Name
			humHash[:temp] = "Humidity"
			# Data
			humArray = Array.new
			dataQuery.each do |tuple|

				newReading = [tuple.recorded_at, tuple.humidity]
				humArray.push(newReading)

			end
			humHash[:data] = humArray

			# Return data 
			return dataInput
		end

		

	end

end
