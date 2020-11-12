CREATE TABLE IF NOT EXISTS address_log(
  id SERIAL PRIMARY KEY
, address_id int
, street_address varchar(100)
, latitude decimal(9,6)
, longitude decimal(9,6)
, area int
, city varchar(30)
, state_id int
, zip_code int
, flag int
, create_time TIMESTAMP without time zone
, log_uuser_id int
);

CREATE table if not EXISTS address(
    id serial primary key
    ,address_log_id int
    ,flag int
    ,create_time TIMESTAMP without time zone
    ,log_uuser_id int
);


create TABLE IF NOT EXISTS uuser(
	id SERIAL PRIMARY KEY
	, uuser_log_id int
    , username varchar(30)
	, create_time TIMESTAMP without time zone
	, flag int
    , log_uuser_id int
	);


CREATE TABLE IF NOT EXISTS uuser_log (
	id SERIAL PRIMARY KEY
	, first_name varchar(50)
	, last_name varchar(50)
	, email_address varchar(100)
	, phone_number varchar(20)
	, pwd varchar(100)
	, tmp_pwd varChar(100)
	, flag int
	, create_time TIMESTAMP without time zone
	, log_uuser_id int
	);

