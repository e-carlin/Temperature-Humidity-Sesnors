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

		# Get temperature and humidity from only one sensor
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

		# Get temperature or humidity for all sensors
		if allSensors == true

			# First, get all of the sensors
			sensorQuery = Nodes.select(:node_id).to_a
			# Store the node id's in an array
			sensors = Array.new
			# Add the values
			sensorQuery.each do |tuple|
				sensors.push(tuple.node_id)
			end

			# What will be returned to the graphs
			allSensorData = Array.new

			# Get each data series
			for sensor in sensors

				# One data series
				dataSeries = {}
				# Series Name
				dataSeries[:name] = sensor

				# The actual data
				dataQuery = Reading.select(:recorded_at, measurement).where(node_id: sensor, recorded_at: startDate.beginning_of_day..endDate.end_of_day).to_a
				# Format data for graph
				dataArray = Array.new
				dataQuery.each do |tuple|
					dataArray.push([tuple.recorded_at, tuple.measurment])
				end

				# Add to hash
				dataSeries[:data] = dataArray
				# Push to array
				allSensorData.push(dataSeries)

			end

			# Return data
			return allSensorData 

		end

		# Otherwise, we return X-many sensors and compare their measurements
		# What will be returned to the graphs
		multiSensorData = Array.new

		# Get each data series
		for sensor in selectSensors

			# One data series
			dataSeries = {}
			# Series Name
			dataSeries[:name] = sensor

			# The actual data
			dataQuery = Reading.select(:recorded_at, measurement).where(node_id: sensor, recorded_at: startDate.beginning_of_day..endDate.end_of_day).to_a
			# Format data for graph
			dataArray = Array.new
			dataQuery.each do |tuple|
				dataArray.push([tuple.recorded_at, tuple.measurment])
			end

			# Add to hash
			dataSeries[:data] = dataArray
			# Push to array
			multiSensorData.push(dataSeries)

		end

		# Return data
		return mutliSensorData 	

	end

end
