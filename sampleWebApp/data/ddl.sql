
.mode columns
.headers on
.nullvalue NULL
PRAGMA foreign_keys = ON;

create table User(
	userName text unique primary key,
	password text
);