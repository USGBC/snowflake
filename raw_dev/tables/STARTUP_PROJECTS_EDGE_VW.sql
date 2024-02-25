--liquibase formatted sql

--changeset  20240217:STARTUP_PROJECTS_EDGE_VW  

use schema API;
create or replace view STARTUP_PROJECTS_EDGE_VW as 
select * from 
RAW_DEV.api.STARTUP_PROJECTS_EDGE1;
