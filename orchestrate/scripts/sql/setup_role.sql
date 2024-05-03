use role accountadmin;

create or replace warehouse online_store_wh with warehouse_size='x-small';
create database if not exists online_store_db;
create role if not exists dev_role;

show grants on warehouse online_store_wh;

grant role dev_role to user your_username;
grant usage on warehouse online_store_wh to role dev_role;
grant all on database online_store_db to role dev_role;
grant all on all schemas in database online_store_db to role dev_role;
grant all on future schemas in database online_store_db to role dev_role;
use role dev_role;

create schema if not exists raw;

-- clean up
use role accountadmin;

drop schema if exists raw;
drop warehouse if exists online_store_wh;
drop database if exists online_store_db;
drop role if exists dev_role;