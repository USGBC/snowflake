--liquibase formatted sql

--changeset  202402162:sample-table

use schema API;
create table IF NOT EXISTS channels
(
dim_channel_key smallint NOT NULL,
dim_channel_key_key smallint NOT NULL,
channel_name character varying(40) NOT NULL,
channel_category character varying(400) NOT NULL,
channel_type character varying(20) NOT NULL,
channel_sub_type character varying(20) NOT NULL,
storing_order integer NOT NULL,
channel_display_name character varying(40) NOT NULL,
channel_code character varying(20) NOT NULL,
created_date timestamp without time zone NOT NULL,
last_modified_date timestamp without time zone NOT NULL,
oem_owner character varying(50) NOT NULL,
publisher character varying(100) NOT NULL
)
;
