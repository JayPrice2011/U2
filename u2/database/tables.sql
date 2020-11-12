--
-- _procs
--
-- Table
CREATE TABLE IF NOT EXISTS _procs(
  id SERIAL PRIMARY KEY,
  proc text,
  qry text,
  added date default current_date
);

-- data
INSERT INTO _procs (proc, qry) VALUES ('AddUser', 'INSERT INTO users (username, password) VALUES (%s,%s);');
INSERT INTO _procs (proc, qry) VALUES ('ListUsers', 'SELECT * FROM users;');
INSERT INTO _procs (proc, qry) VALUES ('VerifyLogin', 'SELECT * FROM users WHERE username=%s;');
INSERT INTO _procs (proc, qry) VALUES ('AddUdcCode', 'INSERT INTO udc_code(table_name, code, name, required) values(%s,%s,%s,%s);');
INSERT INTO _procs (proc, qry) VALUES ('AddUdcValue', 'INSERT INTO udc_value(abv, name) values(%s,%s);');
INSERT INTO _procs (proc, qry) VALUES ('AddMasterValue', 'INSERT INTO udc_master(value_id, code_id) values(%s, %s);');
INSERT INTO _procs (proc, qry) VALUES ('RemoveMasterValue', 'DELETE FROM udc_master where value_id=%s and code_id=%s;');
INSERT INTO _procs (proc, qry) VALUES ('GetMasterValues', 'select v.id as valueId, c.id as codeId, m.id as masterId, v.abv, v.name, false as deleted from udc_value v join udc_master m on (v.id=m.value_id) join udc_code c on (c.id=m.code_id) where c.id=%s order by v.id DESC');
INSERT INTO _procs (proc, qry) VALUES ('GetValues', 'SELECT id, abv, name, code_id FROM udc_value;');
INSERT INTO _procs (proc, qry) VALUES ('GetCodes', 'SELECT * FROM udc_code order by id;');
INSERT INTO _procs (proc, qry) VALUES ('GetMasterCodes', 'SELECT * FROM udc_master_vw order by code_id;');


--
-- users
--
-- Table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username text,
    password text,
    added date default current_date,
    admin integer default 0
);


--
-- udc_code
--
-- Table
CREATE TABLE IF NOT EXISTS udc_code(
  id SERIAL PRIMARY KEY,
  table_name varchar,
  code varchar,
  name varchar,
  required boolean,
  added date default current_date,
  multiple boolean
);

-- data
INSERT INTO udc_code (table_name, code, name, required, multiple) VALUES ('currcode', 'CUR1', 'Currency type', 't', 'f'); --1
INSERT INTO udc_code (table_name, code, name, required, multiple) VALUES ('currcode', 'CUR2', 'Currency Group', 't', 'f'); --2
INSERT INTO udc_code (table_name, code, name, required, multiple) VALUES ('company', 'CO1', 'Company Type', 't', 'f' ); --3
INSERT INTO udc_code (table_name, code, name, required, multiple) VALUES ('company', 'CO2', 'Company Region', 't','t'); --4
INSERT INTO udc_code (table_name, code, name, required, multiple) VALUES ('company', 'CCO', 'Country Code', 't','f'); --5
INSERT INTO udc_code (table_name, code, name, required, multiple) VALUES ('company', 'SCO', 'State Code', 'f','t'); --6
INSERT INTO udc_code (table_name, code, name, required, multiple) VALUES ('language', 'lang', 'Language', 't','f'); --7

--
-- udc_value
--
-- Table
CREATE TABLE IF NOT EXISTS udc_value(
    id SERIAL PRIMARY KEY,
    abv varchar,
    name varchar,
    added timestamp default current_timestamp,
    code_id int
);
-- data
INSERT INTO udc_value (abv, name, code_id) VALUES  ('DOM', 'Domestic', 1);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('EXCH', 'Exchange', 1);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('EU', 'Europe', 7);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('ENG', 'English',7);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('ESP', 'Spanish', 7);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('DEN', 'Danish', 7);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('PROP', 'Propane Company/Division', 3);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('WTR', 'Water Company/Division', 3);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('LEG', 'Legal Entity', 3);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('ENY', 'East New York',4);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('WNY', 'West New York',4);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('USA', 'United States of America', 5);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('ENG', 'England', 5);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('IN', 'Indiana', 6);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('NJ', 'New Jersey', 6);
INSERT INTO udc_value (abv, name, code_id) VALUES  ('WY', 'Wyoming', 6);

CREATE TABLE IF NOT EXISTS udc_master (
    id SERIAL PRIMARY KEY,
    value_id int,
    code_id int,
    added date default current_date
);

CREATE VIEW udc_code_vw as 
  select a.id code_id, a.code, a.name codename, a.required
  , b.id value_id, b.abv value_abv, b.name value_name
  from udc_code a, udc_value b 
  where a.id = b.code_id;

CREATE VIEW udc_master_vw as
  select a.id code_id, a.code, a.name code_name, a.required,a.multiple, b.name value_name, b.abv, b.id value_id
  from
  (select a.id, a.code, a.name, a.required,a.multiple,b.value_id
    FROM udc_code a
    LEFT JOIN udc_master b
    ON a.id = b.code_id) a
    LEFT JOIN udc_value b
    on a.value_id = b.id;

