--liquibase formatted sql

--changeset venky:v3

create table organization
(
org_id smallint NOT NULL,
org_name character varying(40) NOT NULL,
org_type character varying(20) NOT NULL
)
;
