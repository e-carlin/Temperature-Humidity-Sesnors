=================
About the Schema
=================

------
|User|
------
Straightforward, users who can see the website.

------
|Admin|
------
These are users with the ability to manage other users.

	* Add new users.
	* Delete old users.
	* Grant admin priveleges of pre-exisitng users.

------------
|MuseumCase|
------------
These are the exhibit cases. Serves as a reference point.

--------
|Sensor|
--------
The Moteino sensors. I don't know how they transmit data, but I figured for information to store, we'd want these two values.

	* id: The unique identifier for the sensor.
	* batteryLife: Lets us know if a battery needs to be replaced soon

----------
|Contains|
----------
Shows which cases contain which sensors. Useful for data vizualization and if we need multiple sensors to a case.

------
|Data|
------
The data the Moteino's transmit.

	* id: Which sensor sent the data
	* timeStamp: YYYY/MM/DD - HH/MM (The time of transmission)
	* temperature: Temperature, probably Farenheit
	* humidity: Humidity in percentage

This at least covers the minimum desired information