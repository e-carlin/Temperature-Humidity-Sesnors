class GraphsController < ApplicationController
		#Added to make sure that only logged in users can access our site
	before_action :require_login 

	def show
		#render template: "pages/#{params[:page]}" #TOOD: Do we need this? we don't have a show view...
	end

	def index
		@nodeList = nodes
	end

	# Returns the node with the lowest readings
	# Param t_or_h: 'true' for temperature readings, 'false' for humidity readings
	def minNode(t_or_h)

		if t_or_h == true

			# Get minimum value
			min_val = Reading.select(:temperature, :recorded_at).where(recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).minimum(:temperature)
			# Return the node (or nodes) with the minimum values
			node_query = Reading.select(:node_id, :temperature).where(temperature: min_val)
			node_query.each do |query|

				# Return the node id
				return query.node_id

			end

		else

			# Get minimum value
			min_val = Reading.select(:humidity, :recorded_at).where(recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).minimum(:humidity)
			# Return the node (or nodes) with the minimum values
			node_query = Reading.select(:node_id, :humidity).where(humidity: min_val)
			node_query.each do |query|

				# Return the node id
				return query.node_id

			end
		end
	end
	helper_method :minNode


	# Returns the node with the highest readings
	# Param t_or_h: 'true' for temperature readings, 'false' for humidity readings
	def maxNode(t_or_h)

		if t_or_h == true

			# Get maximum value
			max_val = Reading.select(:temperature, :recorded_at).where(recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).maximum(:temperature)
			# Return the node (or nodes) with the maximum values
			node_query = Reading.select(:node_id, :temperature).where(temperature: max_val)
			node_query.each do |query|

				# Return the node id
				return query.node_id

			end

		else

			# Get maximum value
			max_val = Reading.select(:humidity, :recorded_at).where(recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).maximum(:humidity)
			# Return the node (or nodes) with the maximum values
			node_query = Reading.select(:node_id, :humidity).where(humidity: max_val)
			node_query.each do |query|

				# Return the node id
				return query.node_id

			end

		end

	end
	helper_method :maxNode


	# Returns the maximum bound for the graph's y-axis
	# Param node: The node_id of the node of interest
	def upperQuartile(node)
		# Max humidity value from the node in the past day
		max_hum = Reading.select(:humidty, :recorded_at).where(node_id: node, recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).maximum(:humidity)
		# Max temperature value from the node in the past day
		max_temp = Reading.select(:temperature, :recorded_at).where(node_id: node, recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).maximum(:temperature)
		# Determine the parameter with the highest value
		max_val = [max_hum, max_temp].max	

		# Check if node has returned any values for the current day
		# Set the max bound into quartiles
		unless max_val.nil? 
			offset = 25 - (max_val % 25)
			# Visibility adjustment
			if offset == 1 
				offset = 5
			end
			return max_val + offset
		end
		# Otherwise, set default max for empty graph
		return 100
	end
	helper_method :upperQuartile


	# Returns the minimum bound for the graph's y-axis
	# Param node: The node_id of the node of interest
	def lowerQuartile(node)
		# Min humidity value from the node in the past day
		min_hum = Reading.select(:humidity, :recorded_at).where(node_id: node, recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).minimum(:humidity)
		# Min temperature value from the node in the past day
		min_temp = Reading.select(:temperature, :recorded_at).where(node_id: node, recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).minimum(:temperature)
		# Determine the parameter with the lowest value
		min_val = [min_hum, min_temp].min

		# Check if node has returned any values for the current day
		# Set the min bound into quartiles
		unless min_val.nil?
			offset = (min_val % 25)
			# Visibility adjustment
			if offset == 1 
				offset = 5
			end			
			return min_val - (offset)
		end
		# Graph will be empty, set default min
		return 0
	end
	helper_method :lowerQuartile

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
		dataQuery = Reading.select(:recorded_at, :temperature, :humidity).where(node_id: sensor, recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).to_a

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
		dataQuery = Reading.select(:recorded_at, :node_id, :temperature).where(recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).to_a

		# Each data hash will be for a single node
		@nodeList.each do |node|

			# Get the id of the current node
			node_id = node[0]

			# The hash
			nodeHash = {}
			# The name
			nodeHash[:name] = nodeName(node)
			# What we will put the data in
			dataArray = Array.new

			# Add data to the array
			dataQuery.each do |query|

				# This reading comes from our node of interest
				if query.node_id == node_id
					# Format the data into an array entry and push
					reading = [query.recorded_at, query.temperature]
					dataArray.push(reading)
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
		dataQuery = Reading.select(:recorded_at, :node_id, :humidity).where(recorded_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).to_a

		# Each data hash will be for a single node
		@nodeList.each do |node|

			# Get the id of the current node
			node_id = node[0]

			# The hash
			nodeHash = {}
			# The name
			nodeHash[:name] = nodeName(node)
			# What we will put the data in
			dataArray = Array.new

			# Add data to the array
			dataQuery.each do |query|

				# Thisquery reading comes from our node of interest
				if query.node_id == node_id
					# Format the data into an array entry and push
					reading = [query.recorded_at, query.humidity]
					dataArray.push(reading)
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


