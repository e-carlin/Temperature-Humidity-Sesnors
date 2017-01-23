.mode columns
.headers on
.nullvalue NULL
PRAGMA foreign_keys = ON;

create table User(
	username text unique primary key,
	password text
);