select 'insert into udc master';

select 'currcode';

insert into udc_code(id, table_name, code, name, required)
values(1, 'currcode', 'CUR1', 'Currency type', True);

insert into udc_value(abv, name, code_id)
values('DOM', 'Domestic', 1);

insert into udc_value(abv, name, code_id)
values('EXCH', 'Exchange', 1);


insert into udc_code(id, table_name, code, name, required)
values(2, 'currcode', 'CUR2', 'Currency Group', True);

insert into udc_value(abv, name, code_id)
values('NA', 'North America', 2, 'currcode');

insert into udc_value(abv, name, code_id)
values('EU', 'Europe', 2 );


select 'company';


insert into udc_code(id, table_name, code, name, required)
values(3, 'company', 'LANG', 'Language', True);

insert into udc_value(abv, name, code_id)
values('ENG', 'English', 3);

insert into udc_value(abv, name, code_id)
values('ESP', 'Spanish', 3);

insert into udc_value(abv, name, code_id)
values('DEN', 'Danish', 3);


insert into udc_code(id, table_name, code, name, required)
values(4, 'company', 'CO1', 'Company Type', True);

insert into udc_value(abv, name, code_id)
values('PROP', 'Propane Company/Division', 4);

insert into udc_value(abv, name, code_id )
values('WTR', 'Water Company/Division', 4);

insert into udc_value(abv, name, code_id )
values('LEG', 'Legal Entity', 4);


insert into udc_code(id, table_name, code, name, required)
values(5, 'company', 'CO2', 'Company Region', True);

insert into udc_value(abv, name, code_id)
values('ENY', 'East New Year', 5);

insert into udc_value(abv, name, code_id )
values('WNY', 'West New Year', 5);


insert into udc_code(id, table_name, code, name, required)
values(6, 'company', 'CCO', 'Country Code', True);

insert into udc_value(abv, name, code_id)
values('USA', 'United States of America', 6);


insert into udc_value(abv, name, code_id)
values('ENG', 'England', 6);

insert into udc_code(id, table_name, code, name, required)
values(7, 'company', 'SCO', 'State Code', False);

insert into udc_value(abv, name, code_id)
values('IN', 'Indiana', 7);

insert into udc_value(abv, name, code_id)
values('NJ', 'New Jersey', 7);

insert into udc_value(abv, name, code_id)
values('WY', 'Wyoming', 7);

select 'end mvp data load';