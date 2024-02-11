--liquibase formatted sql

--changeset venky:department table

create table department
(
id smallint NOT NULL,
department_name character varying(40) NOT NULL,
department_type character varying(20) NOT NULL
)
;