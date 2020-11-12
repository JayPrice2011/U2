
insert into address_log (address_id, street_address, latitude, longitude, city, state_id, zip_code, flag, create_time, log_uuser_id, area)
values (1,'222 some street', 44.44999, 55.5555,  'bosie', 4, 33333, 0, CURRENT_TIMESTAMP,1, 5500);

insert into address_log (address_id, street_address, latitude, longitude, city, state_id, zip_code, flag, create_time, log_uuser_id, area)
values (1,'222 some street', 44.44999, 55.5555,  'bosie', 4, 33333, 0, CURRENT_TIMESTAMP,1, 6000);

insert into uuser_log (first_name, last_name, email_address, phone_number, pwd, flag, create_time, log_uuser_id)
values('peter','antley','peterantley@gmail.com', '868-444-0000', 'password',0,CURRENT_TIMESTAMP, 1);

insert into uuser_log (first_name, last_name, email_address, phone_number, pwd, flag, create_time, log_uuser_id)
values('peter','antley','pete@gmail.com', '868-444-0000', 'password2',0,CURRENT_TIMESTAMP, 1);

insert into uuser (uuser_log_id, username, create_time, flag, log_uuser_id)
values(2, 'antleypk', CURRENT_TIMESTAMP, 0, 1);