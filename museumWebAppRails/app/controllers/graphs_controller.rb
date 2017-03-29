class GraphsController < ApplicationController
		#Added to make sure that only logged in users can access our site
	before_action :require_login 

	def show
		#render template: "pages/#{params[:page]}" #TOOD: Do we need this? we don't have a show view...
	end

	def index
		@nodeList = nodes
	end

	# Returns an array of node id's
	def nodes
		# Query the database
		nodeQuery = Node.select(:node_id)
		# Place the query in an array
		nodeArray = Array.new
		nodeQuery.each do |node|
			nodeArray.push [node.node_id]
		end
		return nodeArray
	end
	helper_method :numNodes

	# Returns a node's name based on its id
	def nodeName(id)
		nameQuery = Node.select(:name).where(node_id: id)

		# This only loops through once, but I don't know how to extract just one tuple from a query
		name = ""
		nameQuery.each do |tuple|
			name = tuple.name
		end
		return name
	end
	helper_method :nodeName

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

	# Gets the past day's temperature readings from all sensors
	def allTemp

		# We return the data in an array of hashes
		dataInput = []		

		# Query the data (every reading that has happened today)
		dataQuery = Reading.select(:recorded_at, :node_id, :temperature).where(recorded_at: Date.today.beginning_of_day..Date.today.end_of_day).to_a

		# Each data hash will be for a single node
		@nodeList.each do |node|

			# The hash
			nodeHash = {}
			# The name
			nodeHash[:name] = nodeName(node)
			# What we will put the data in
			dataArray = Array.new

			# Add data to the array
			dataQuery.each do |tuple|

				# This reading comes from our node of interest
				if tuple.node_id == node.node_id
					dataArray.push[tuple.recorded_at, tuple.temperature]
				end

			end

			# Set the data value
			nodeHash[:data] = dataArray
			# Add this node's information to our array
			dataInput.push(nodeHash)

		end

		# Return the result
		return dataInput

	end
	helper_method :allTemp

	# Gets the past day's humidity readings from all sensors
	def allHum

		# We return the data in an array of hashes
		dataInput = []		

		# Query the data (every reading that has happened today)
		dataQuery = Reading.select(:recorded_at, :node_id, :humidity).where(recorded_at: Date.today.beginning_of_day..Date.today.end_of_day).to_a

		# Each data hash will be for a single node
		@nodeList.each do |node|

			# The hash
			nodeHash = {}
			# The name
			nodeHash[:name] = nodeName(node)
			# What we will put the data in
			dataArray = Array.new

			# Add data to the array
			dataQuery.each do |tuple|

				# This reading comes from our node of interest
				if tuple.node_id == node.node_id
					dataArray.push[tuple.recorded_at, tuple.humidity]
				end

			end

			# Set the data value
			nodeHash[:data] = dataArray
			# Add this node's information to our array
			dataInput.push(nodeHash)

		end

		# Return the result
		return dataInput

	end
	helper_method :allHum

	

end


