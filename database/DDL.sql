.mode columns
.headers on
.nullvalue NULL
PRAGMA foreign_keys = ON;

create table User(
	userName text unique primary key,
	password text
);

create table Admin(
	userName text unique,
	foreign key(userName) references User(userName)
);

create table MuseumCase(
	name text unique
);

create table Sensor(
	id integer unique,
	batteryLife integer 
);

create table Contains(
	caseName text,
	sensorID integer unique,
	foreign key(caseName) references MuseumCase(name),
	foreign key(sensorID) references Sensor(id)
);

create table Data(
	sensorID integer,
	timeStamp time,
	temperature integer,
	humidity integer,
	foreign key(sensorID) references Sensor(id)
); 