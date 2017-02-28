# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creating dummy data for testing purposes
# DateTime format, 'yyyy-mm-dd hh:mm:ss'

# Empty shell for nodes
# 	{node_id:, created_at:, updated_at:}

	nodes = Node.create([

		{node_id: 1, created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},
		{node_id: 2, created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},
		{node_id: 3, created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},
		{node_id: 4, created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'}

		])

# Empty shell for sensors
#  	{ pin: , node_id: , created_at: , updated_at: }

	sensors = Sensor.create([

		{ pin: 1, node_id: 1, created_at: '2017-01-03 14:32:25', updated_at: '2017-01-08 14:32:25'},
		{ pin: 2, node_id: 1, created_at: '2017-01-03 14:32:25', updated_at: '2017-01-08 14:32:25'},
		{ pin: 3, node_id: 1, created_at: '2017-01-03 14:32:25', updated_at: '2017-01-08 14:32:25'},
		{ pin: 4, node_id: 2, created_at: '2017-01-03 14:32:25', updated_at: '2017-01-08 14:32:25'},
		{ pin: 5, node_id: 3, created_at: '2017-01-03 14:32:25', updated_at: '2017-01-08 14:32:25'},
		{ pin: 6, node_id: 3, created_at: '2017-01-03 14:32:25', updated_at: '2017-01-08 14:32:25'},
		{ pin: 7, node_id: 4, created_at: '2017-01-03 14:32:25', updated_at: '2017-01-08 14:32:25'}

		])

# Empty shell for readings, if more test data is needed
# 	{ pin: , node_id: , temperature: , humidity: , recorded_at: , created_at: , updated_at: },

	#'One Day' of readings
	readings = Reading.create([

		#Node 1, Sensor 1
		{ pin: 1, node_id: 1, temperature: 71, humidity: 50, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ pin: 1, node_id: 1, temperature: 71, humidity: 50, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ pin: 1, node_id: 1, temperature: 71, humidity: 50, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 1, Sensor 2
		{ pin: 2, node_id: 1, temperature: 70, humidity: 52, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ pin: 2, node_id: 1, temperature: 68, humidity: 57, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ pin: 2, node_id: 1, temperature: 69, humidity: 60, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 1, Sensor 3
		{ pin: 3, node_id: 1, temperature: 78, humidity: 45, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ pin: 3, node_id: 1, temperature: 75, humidity: 44, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ pin: 3, node_id: 1, temperature: 72, humidity: 47, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 2, Sensor 4
		{ pin: 4, node_id: 2, temperature: 50, humidity: 63, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ pin: 4, node_id: 2, temperature: 55, humidity: 60, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ pin: 4, node_id: 2, temperature: 53, humidity: 65, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 3, Sensor 5
		{ pin: 5, node_id: 3, temperature: 65, humidity: 68, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ pin: 5, node_id: 3, temperature: 66, humidity: 66, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ pin: 5, node_id: 3, temperature: 66, humidity: 67, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 3, Sensor 6
		{ pin: 6, node_id: 3, temperature: 35, humidity: 75, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ pin: 6, node_id: 3, temperature: 31, humidity: 82, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ pin: 6, node_id: 3, temperature: 40, humidity: 74, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 4, Sensor 7 (One packet dropped)
		{ pin: 7, node_id: 4, temperature: 72, humidity: 52, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ pin: 7, node_id: 4, temperature: 71, humidity: 53, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'}

		])