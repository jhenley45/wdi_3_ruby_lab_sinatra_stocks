DROP TABLE IF EXISTS people;

CREATE TABLE people (
	id serial primary key,
	name text,
	phone text
);

INSERT INTO people (name, phone) VALUES ('David', '432-333-4533')
