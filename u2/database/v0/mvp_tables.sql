CREATE TABLE IF NOT EXISTS udc_code(
  id SERIAL PRIMARY KEY,
  table_name varchar,
  code varchar,
  name varchar,
  required boolean
);

CREATE TABLE IF NOT EXISTS udc_value(
    id SERIAL PRIMARY KEY,
    abv varchar,
    name varchar,
    code_id int,
    CONSTRAINT fk_code
       FOREIGN KEY (code_id)
           REFERENCES udc_code(id)
);

CREATE TABLE IF NOT EXISTS udc_master (
    id SERIAL PRIMARY KEY,
    value_id int,
    CONSTRAINT fk_value
        FOREIGN KEY (value_id)
            REFERENCES udc_value (id)
);


CREATE OR REPLACE VIEW udc_view as
    SELECT udc_value.id AS id,
        udc_code.code AS code,
        udc_code.name AS code_name,
        udc_code.table_name AS table_name,
        udc_value.abv AS abv,
        udc_value.name AS name
    FROM udc_code, udc_value
    WHERE udc_code.id = udc_value.code_id
    ORDER by udc_value.id;

CREATE OR REPLACE VIEW udc_master_view as
    SELECT udc_value.id AS id,
        udc_code.code AS code,
        udc_code.name AS description,
        udc_code.table_name AS table_name,
        udc_value.abv AS abv,
        udc_value.name AS name
    FROM udc_master inner join udc_value
        on udc_master.value_id = udc_value.id
            inner join udc_code
                on udc_value.code_id = udc_code.id;