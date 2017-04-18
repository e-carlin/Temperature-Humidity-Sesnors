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

		{node_id: 1, name: "Name for n_id 1", voltage: 3310, last_reading: '2017-01-20 16:00:00', created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},
		{node_id: 2, name: "Name for n_id 2", created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},
		{node_id: 3, name: "Name for n_id 3", created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},
		{node_id: 4, name: "Name for n_id 4", created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},
		{node_id: 5, name: "Name for n_id 5", created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},
		{node_id: 6, name: "Name for n_id 6", created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},
		{node_id: 7, name: "Name for n_id 7", created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05'},

		])

	users = User.create([

		{created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05', email: 'mgilbert@pugetsound.edu', admin: true, encrypted_password: 'BlahBlah', confirmation_token: 'boopboop', remember_token: 'Set'},
		{created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05', email: 'mbogert@pugetsound.edu', admin: false, encrypted_password: 'BlahBlah', confirmation_token: 'boopboop', remember_token: 'Set'},
		{created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05', email: 'ecarlin@pugetsound.edu', admin: true, encrypted_password: 'BlahBlah', confirmation_token: 'boopboop', remember_token: 'Set'},
		{created_at: '2017-01-01 10:12:15', updated_at: '2017-01-07 12:30:05', email: 'gabe@pugetsound.edu', admin: false, encrypted_password: 'BlahBlah', confirmation_token: 'boopboop', remember_token: 'Set'},
		{created_at: '2017-03-01 10:12:15', updated_at: '2017-03-07 12:30:05', email: 'mark@pugetsound.edu', admin: true, encrypted_password: 'BlahBlah', confirmation_token: 'boopboop', remember_token: 'Set'},
		])


# Empty shell for readings, if more test data is needed
# 	{ pin: , node_id: , temperature: , humidity: , recorded_at: , created_at: , updated_at: },

	#'One Day' of readings
	readings = Reading.create([

		#Node 1, Sensor 1
		{ node_id: 1, temperature: 71, humidity: 50, recorded_at: '2017-04-18 08:00:00'},
		{ node_id: 1, temperature: 71, humidity: 50, recorded_at: '2017-04-18 12:00:00'},
		{ node_id: 1, temperature: 71, humidity: 50, recorded_at: '2017-04-18 16:00:00'},
		#Node 1, Sensor 2
		{ node_id: 2, temperature: 70, humidity: 52, recorded_at: '2017-04-18 08:00:00'},
		{ node_id: 2, temperature: 68, humidity: 57, recorded_at: '2017-04-18 12:00:00'},
		{ node_id: 2, temperature: 69, humidity: 60, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		{ node_id: 2, temperature: 69, humidity: 60, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		{ node_id: 2, temperature: 69, humidity: 60, recorded_at: '2017-01-21 23:00:00', created_at: '2017-01-20 23:05:00', updated_at: '2017-01-20 23:05:00'},		
		#Node 1, Sensor 3
		{ node_id: 3, temperature: 78, humidity: 45, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ node_id: 3, temperature: 75, humidity: 44, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ node_id: 3, temperature: 72, humidity: 47, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 2, Sensor 4
		{ node_id: 4, temperature: 50, humidity: 63, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ node_id: 4, temperature: 55, humidity: 60, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ node_id: 4, temperature: 53, humidity: 65, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 3, Sensor 5
		{ node_id: 5, temperature: 65, humidity: 68, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ node_id: 5, temperature: 66, humidity: 66, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ node_id: 5, temperature: 66, humidity: 67, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 3, Sensor 6
		{ node_id: 6, temperature: 35, humidity: 75, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ node_id: 6, temperature: 31, humidity: 82, recorded_at: '2017-01-20 12:00:00', created_at: '2017-01-20 12:05:00', updated_at: '2017-01-20 12:05:00'},
		{ node_id: 6, temperature: 40, humidity: 74, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},
		#Node 4, Sensor 7 (One packet dropped)
		{ node_id: 7, temperature: 72, humidity: 52, recorded_at: '2017-01-20 08:00:00', created_at: '2017-01-20 08:05:00', updated_at: '2017-01-20 08:05:00'},
		{ node_id: 7, temperature: 71, humidity: 53, recorded_at: '2017-01-20 16:00:00', created_at: '2017-01-20 16:05:00', updated_at: '2017-01-20 16:05:00'},

		#One week of measurements for sensor 4 (2 dropped packets on teh 25th and 27th)
		{ node_id: 2, temperature: 50, humidity: 63, recorded_at: '2017-01-21 08:00:00', created_at: '2017-01-21 08:05:00', updated_at: '2017-01-21 08:05:00'},
		{ node_id: 2, temperature: 55, humidity: 60, recorded_at: '2017-01-21 12:00:00', created_at: '2017-01-21 12:05:00', updated_at: '2017-01-21 12:05:00'},
		{ node_id: 2, temperature: 53, humidity: 65, recorded_at: '2017-01-21 16:00:00', created_at: '2017-01-21 16:05:00', updated_at: '2017-01-21 16:05:00'},
		{ node_id: 2, temperature: 50, humidity: 63, recorded_at: '2017-01-22 08:00:00', created_at: '2017-01-22 08:05:00', updated_at: '2017-01-22 08:05:00'},
		{ node_id: 2, temperature: 55, humidity: 60, recorded_at: '2017-01-22 12:00:00', created_at: '2017-01-22 12:05:00', updated_at: '2017-01-22 12:05:00'},
		{ node_id: 2, temperature: 53, humidity: 65, recorded_at: '2017-01-22 16:00:00', created_at: '2017-01-22 16:05:00', updated_at: '2017-01-22 16:05:00'},
		{ node_id: 2, temperature: 50, humidity: 63, recorded_at: '2017-01-23 08:00:00', created_at: '2017-01-23 08:05:00', updated_at: '2017-01-23 08:05:00'},
		{ node_id: 2, temperature: 55, humidity: 60, recorded_at: '2017-01-23 12:00:00', created_at: '2017-01-23 12:05:00', updated_at: '2017-01-23 12:05:00'},
		{ node_id: 2, temperature: 53, humidity: 65, recorded_at: '2017-01-23 16:00:00', created_at: '2017-01-23 16:05:00', updated_at: '2017-01-23 16:05:00'},
		{ node_id: 2, temperature: 50, humidity: 63, recorded_at: '2017-01-24 08:00:00', created_at: '2017-01-24 08:05:00', updated_at: '2017-01-24 08:05:00'},
		{ node_id: 2, temperature: 55, humidity: 60, recorded_at: '2017-01-24 12:00:00', created_at: '2017-01-24 12:05:00', updated_at: '2017-01-24 12:05:00'},
		{ node_id: 2, temperature: 53, humidity: 65, recorded_at: '2017-01-24 16:00:00', created_at: '2017-01-24 16:05:00', updated_at: '2017-01-24 16:05:00'},
		{ node_id: 2, temperature: 50, humidity: 63, recorded_at: '2017-01-25 08:00:00', created_at: '2017-01-25 08:05:00', updated_at: '2017-01-25 08:05:00'},
		{ node_id: 2, temperature: 55, humidity: 60, recorded_at: '2017-01-25 12:00:00', created_at: '2017-01-25 12:05:00', updated_at: '2017-01-25 12:05:00'},
		{ node_id: 2, temperature: 50, humidity: 63, recorded_at: '2017-01-26 08:00:00', created_at: '2017-01-26 08:05:00', updated_at: '2017-01-26 08:05:00'},
		{ node_id: 2, temperature: 55, humidity: 60, recorded_at: '2017-01-26 12:00:00', created_at: '2017-01-26 12:05:00', updated_at: '2017-01-26 12:05:00'},
		{ node_id: 2, temperature: 53, humidity: 65, recorded_at: '2017-01-26 16:00:00', created_at: '2017-01-26 16:05:00', updated_at: '2017-01-26 16:05:00'},
		{ node_id: 2, temperature: 50, humidity: 63, recorded_at: '2017-01-27 08:00:00', created_at: '2017-01-27 08:05:00', updated_at: '2017-01-27 08:05:00'},
		{ node_id: 2, temperature: 55, humidity: 60, recorded_at: '2017-01-27 12:00:00', created_at: '2017-01-27 12:05:00', updated_at: '2017-01-27 12:05:00'},


		#New seeds for testing graphs
		{ node_id: 1, temperature: 71, humidity: 50, recorded_at: '2017-03-15 08:00:00', created_at: '2017-03-15 08:05:00', updated_at: '2017-03-15 08:05:00'},
		{ node_id: 1, temperature: 71, humidity: 50, recorded_at: '2017-03-15 12:00:00', created_at: '2017-03-15 12:05:00', updated_at: '2017-03-15 12:05:00'},
		{ node_id: 1, temperature: 71, humidity: 50, recorded_at: '2017-03-15 16:00:00', created_at: '2017-03-15 16:05:00', updated_at: '2017-03-15 16:05:00'},

		{ node_id: 2, temperature: 70, humidity: 52, recorded_at: '2017-03-15 08:00:00', created_at: '2017-03-15 08:05:00', updated_at: '2017-03-15 08:05:00'},
		{ node_id: 2, temperature: 68, humidity: 57, recorded_at: '2017-03-15 12:00:00', created_at: '2017-03-15 12:05:00', updated_at: '2017-03-15 12:05:00'},
		{ node_id: 2, temperature: 69, humidity: 60, recorded_at: '2017-03-15 16:00:00', created_at: '2017-03-15 16:05:00', updated_at: '2017-03-15 16:05:00'},	
		
		{ node_id: 3, temperature: 78, humidity: 45, recorded_at: '2017-03-15 08:00:00', created_at: '2017-03-15 08:05:00', updated_at: '2017-03-15 08:05:00'},
		{ node_id: 3, temperature: 75, humidity: 44, recorded_at: '2017-03-15 12:00:00', created_at: '2017-03-15 12:05:00', updated_at: '2017-03-15 12:05:00'},
		{ node_id: 3, temperature: 72, humidity: 47, recorded_at: '2017-03-15 16:00:00', created_at: '2017-03-15 16:05:00', updated_at: '2017-03-15 16:05:00'},

		{ node_id: 4, temperature: 50, humidity: 63, recorded_at: '2017-03-15 08:00:00', created_at: '2017-03-15 08:05:00', updated_at: '2017-03-15 08:05:00'},
		{ node_id: 4, temperature: 55, humidity: 60, recorded_at: '2017-03-15 12:00:00', created_at: '2017-03-15 12:05:00', updated_at: '2017-03-15 12:05:00'},
		{ node_id: 4, temperature: 53, humidity: 65, recorded_at: '2017-03-15 16:00:00', created_at: '2017-03-15 16:05:00', updated_at: '2017-03-15 16:05:00'},

		{ node_id: 5, temperature: 65, humidity: 68, recorded_at: '2017-03-15 08:00:00', created_at: '2017-03-15 08:05:00', updated_at: '2017-03-15 08:05:00'},
		{ node_id: 5, temperature: 66, humidity: 66, recorded_at: '2017-03-15 12:00:00', created_at: '2017-03-15 12:05:00', updated_at: '2017-03-15 12:05:00'},
		{ node_id: 5, temperature: 66, humidity: 67, recorded_at: '2017-03-15 16:00:00', created_at: '2017-03-15 16:05:00', updated_at: '2017-03-15 16:05:00'},

		{ node_id: 6, temperature: 35, humidity: 75, recorded_at: '2017-03-15 08:00:00', created_at: '2017-03-15 08:05:00', updated_at: '2017-03-15 08:05:00'},
		{ node_id: 6, temperature: 31, humidity: 82, recorded_at: '2017-03-15 12:00:00', created_at: '2017-03-15 12:05:00', updated_at: '2017-03-15 12:05:00'},
		{ node_id: 6, temperature: 40, humidity: 74, recorded_at: '2017-03-15 16:00:00', created_at: '2017-03-15 16:05:00', updated_at: '2017-03-15 16:05:00'},

		{ node_id: 7, temperature: 72, humidity: 52, recorded_at: '2017-03-15 08:00:00', created_at: '2017-03-15 08:05:00', updated_at: '2017-03-15 08:05:00'},
		{ node_id: 7, temperature: 71, humidity: 53, recorded_at: '2017-03-15 16:00:00', created_at: '2017-03-15 16:05:00', updated_at: '2017-03-15 16:05:00'},

		# March 21st
		{ node_id: 1, name: "Name for n_id 1", temperature: 71, humidity: 50, recorded_at: '2017-03-21 08:00:00', created_at: '2017-03-21 08:05:00', updated_at: '2017-03-21 08:05:00'},
		{ node_id: 1, name: "Name for n_id 1", temperature: 71, humidity: 50, recorded_at: '2017-03-21 12:00:00', created_at: '2017-03-21 12:05:00', updated_at: '2017-03-21 12:05:00'},
		{ node_id: 1, name: "Name for n_id 1", temperature: 71, humidity: 50, recorded_at: '2017-03-21 16:00:00', created_at: '2017-03-21 16:05:00', updated_at: '2017-03-21 16:05:00'},

		{ node_id: 2, name: "Name for n_id 2", temperature: 70, humidity: 52, recorded_at: '2017-03-21 08:00:00', created_at: '2017-03-21 08:05:00', updated_at: '2017-03-21 08:05:00'},
		{ node_id: 2, name: "Name for n_id 2", temperature: 68, humidity: 57, recorded_at: '2017-03-21 12:00:00', created_at: '2017-03-21 12:05:00', updated_at: '2017-03-21 12:05:00'},
		{ node_id: 2, name: "Name for n_id 2", temperature: 69, humidity: 60, recorded_at: '2017-03-21 16:00:00', created_at: '2017-03-21 16:05:00', updated_at: '2017-03-21 16:05:00'},	
		
		{ node_id: 3, name: "Name for n_id 3", temperature: 78, humidity: 45, recorded_at: '2017-03-21 08:00:00', created_at: '2017-03-21 08:05:00', updated_at: '2017-03-21 08:05:00'},
		{ node_id: 3, name: "Name for n_id 3", temperature: 75, humidity: 44, recorded_at: '2017-03-21 12:00:00', created_at: '2017-03-21 12:05:00', updated_at: '2017-03-21 12:05:00'},
		{ node_id: 3, name: "Name for n_id 3", temperature: 72, humidity: 47, recorded_at: '2017-03-21 16:00:00', created_at: '2017-03-21 16:05:00', updated_at: '2017-03-21 16:05:00'},

		{ node_id: 4, name: "Name for n_id 4", temperature: 50, humidity: 63, recorded_at: '2017-03-21 08:00:00', created_at: '2017-03-21 08:05:00', updated_at: '2017-03-21 08:05:00'},
		{ node_id: 4, name: "Name for n_id 4", temperature: 55, humidity: 60, recorded_at: '2017-03-21 12:00:00', created_at: '2017-03-21 12:05:00', updated_at: '2017-03-21 12:05:00'},
		{ node_id: 4, name: "Name for n_id 4", temperature: 53, humidity: 65, recorded_at: '2017-03-21 16:00:00', created_at: '2017-03-21 16:05:00', updated_at: '2017-03-21 16:05:00'},

		{ node_id: 5, name: "Name for n_id 5", temperature: 65, humidity: 68, recorded_at: '2017-03-21 08:00:00', created_at: '2017-03-21 08:05:00', updated_at: '2017-03-21 08:05:00'},
		{ node_id: 5, name: "Name for n_id 5", temperature: 66, humidity: 66, recorded_at: '2017-03-21 12:00:00', created_at: '2017-03-21 12:05:00', updated_at: '2017-03-21 12:05:00'},
		{ node_id: 5, name: "Name for n_id 5", temperature: 66, humidity: 67, recorded_at: '2017-03-21 16:00:00', created_at: '2017-03-21 16:05:00', updated_at: '2017-03-21 16:05:00'},

		{ node_id: 6, name: "Name for n_id 6", temperature: 35, humidity: 75, recorded_at: '2017-03-21 08:00:00', created_at: '2017-03-21 08:05:00', updated_at: '2017-03-21 08:05:00'},
		{ node_id: 6, name: "Name for n_id 6", temperature: 31, humidity: 82, recorded_at: '2017-03-21 12:00:00', created_at: '2017-03-21 12:05:00', updated_at: '2017-03-21 12:05:00'},
		{ node_id: 6, name: "Name for n_id 6", temperature: 40, humidity: 74, recorded_at: '2017-03-21 16:00:00', created_at: '2017-03-21 16:05:00', updated_at: '2017-03-21 16:05:00'},

		{ node_id: 7, name: "Name for n_id 7", temperature: 72, humidity: 52, recorded_at: '2017-03-21 08:00:00', created_at: '2017-03-21 08:05:00', updated_at: '2017-03-21 08:05:00'},
		{ node_id: 7, name: "Name for n_id 7", temperature: 71, humidity: 53, recorded_at: '2017-03-21 16:00:00', created_at: '2017-03-21 16:05:00', updated_at: '2017-03-21 16:05:00'},

		# March 28th
		{ node_id: 1, name: "Name for n_id 1", temperature: 71, humidity: 50, recorded_at: '2017-03-29 08:00:00', created_at: '2017-03-29 08:05:00', updated_at: '2017-03-29 08:05:00'},
		{ node_id: 1, name: "Name for n_id 1", temperature: 71, humidity: 50, recorded_at: '2017-03-29 12:00:00', created_at: '2017-03-29 12:05:00', updated_at: '2017-03-29 12:05:00'},
		{ node_id: 1, name: "Name for n_id 1", temperature: 71, humidity: 50, recorded_at: '2017-03-29 16:00:00', created_at: '2017-03-29 16:05:00', updated_at: '2017-03-29 16:05:00'},

		{ node_id: 2, name: "Name for n_id 2", temperature: 70, humidity: 52, recorded_at: '2017-03-29 08:00:00', created_at: '2017-03-29 08:05:00', updated_at: '2017-03-29 08:05:00'},
		{ node_id: 2, name: "Name for n_id 2", temperature: 68, humidity: 57, recorded_at: '2017-03-29 12:00:00', created_at: '2017-03-29 12:05:00', updated_at: '2017-03-29 12:05:00'},
		{ node_id: 2, name: "Name for n_id 2", temperature: 69, humidity: 60, recorded_at: '2017-03-29 16:00:00', created_at: '2017-03-29 16:05:00', updated_at: '2017-03-29 16:05:00'},	
		
		{ node_id: 3, name: "Name for n_id 3", temperature: 78, humidity: 45, recorded_at: '2017-03-29 08:00:00', created_at: '2017-03-29 08:05:00', updated_at: '2017-03-29 08:05:00'},
		{ node_id: 3, name: "Name for n_id 3", temperature: 75, humidity: 44, recorded_at: '2017-03-29 12:00:00', created_at: '2017-03-29 12:05:00', updated_at: '2017-03-29 12:05:00'},
		{ node_id: 3, name: "Name for n_id 3", temperature: 72, humidity: 47, recorded_at: '2017-03-29 16:00:00', created_at: '2017-03-29 16:05:00', updated_at: '2017-03-29 16:05:00'},

		{ node_id: 4, name: "Name for n_id 4", temperature: 50, humidity: 63, recorded_at: '2017-03-29 08:00:00', created_at: '2017-03-29 08:05:00', updated_at: '2017-03-29 08:05:00'},
		{ node_id: 4, name: "Name for n_id 4", temperature: 55, humidity: 60, recorded_at: '2017-03-29 12:00:00', created_at: '2017-03-29 12:05:00', updated_at: '2017-03-29 12:05:00'},
		{ node_id: 4, name: "Name for n_id 4", temperature: 53, humidity: 65, recorded_at: '2017-03-29 16:00:00', created_at: '2017-03-29 16:05:00', updated_at: '2017-03-29 16:05:00'},

		{ node_id: 5, name: "Name for n_id 5", temperature: 65, humidity: 68, recorded_at: '2017-03-29 08:00:00', created_at: '2017-03-29 08:05:00', updated_at: '2017-03-29 08:05:00'},
		{ node_id: 5, name: "Name for n_id 5", temperature: 66, humidity: 66, recorded_at: '2017-03-29 12:00:00', created_at: '2017-03-29 12:05:00', updated_at: '2017-03-29 12:05:00'},
		{ node_id: 5, name: "Name for n_id 5", temperature: 66, humidity: 67, recorded_at: '2017-03-29 16:00:00', created_at: '2017-03-29 16:05:00', updated_at: '2017-03-29 16:05:00'},

		{ node_id: 6, name: "Name for n_id 6", temperature: 35, humidity: 75, recorded_at: '2017-03-29 08:00:00', created_at: '2017-03-29 08:05:00', updated_at: '2017-03-29 08:05:00'},
		{ node_id: 6, name: "Name for n_id 6", temperature: 31, humidity: 82, recorded_at: '2017-03-29 12:00:00', created_at: '2017-03-29 12:05:00', updated_at: '2017-03-29 12:05:00'},
		{ node_id: 6, name: "Name for n_id 6", temperature: 40, humidity: 74, recorded_at: '2017-03-29 16:00:00', created_at: '2017-03-29 16:05:00', updated_at: '2017-03-29 16:05:00'},

		{ node_id: 7, name: "Name for n_id 7", temperature: 72, humidity: 52, recorded_at: '2017-03-29 08:00:00', created_at: '2017-03-29 08:05:00', updated_at: '2017-03-29 08:05:00'},
		{ node_id: 7, name: "Name for n_id 7", temperature: 71, humidity: 53, recorded_at: '2017-03-29 16:00:00', created_at: '2017-03-29 16:05:00', updated_at: '2017-03-29 16:05:00'}

		])