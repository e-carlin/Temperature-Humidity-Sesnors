
--User
insert into User values("Gerald Ponchus", "12345");
insert into User values("Annabelle", "p@$$w0rd");
--Should Fail
insert into User values("Annabelle", "p@$$w0rd");


--Admin
insert into Admin values("Gerald Ponchus");
--Should Fail
insert into Admin values("Gerald Ponchus");
insert into Admin values("Rando Randy");


--Case
insert into MuseumCase values("East Display");
insert into MuseumCase values("Fur Exhibit");
--Should Fail
insert into MuseumCase values("East Display");


--Sensor
insert into Sensor values(1, 82);
insert into Sensor values(2, 25);
--Should Fail
insert into Sensor values(2, 57);


--Contains
insert into Contains values("Fur Exhibit", 2);
insert into Contains values("East Display", 1);
--Should Fail
insert into Contains values("Gift Shop", 3);
insert into Contains values("East Display", 2);


--Data
insert into Data values(1, "2017-03-22 12:30", 72, 8);