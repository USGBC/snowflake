
--liquibase formatted sql

--changeset  20240225:CURATED_DEV.PRE_STG_COMMON.ALL_TALEND_JOBS_SUCCESS()

use schema API;
CREATE OR REPLACE PROCEDURE ALL_TALEND_JOBS_SUCCESS()
RETURNS VARCHAR(100)
LANGUAGE SQL
EXECUTE AS CALLER
AS 'DECLARE


         v_all_tables_not_success EXCEPTION (-20002, ''All Talend Jobs are not Successfull.'');
        v_tot_cont NUMBER      := (SELECT  distinct count(job_name) tot_jobs 
                                   FROM raw_dev.etl_control.etl_control_stream
                                  where upper(job_status) = upper(''Succeeded''));

         // define log variables
         sp_proc_name := ''curated_dev.pre_stg_common.All_Talend_Jobs_success'';
         sp_start_time  timestamp := (SELECT CURRENT_TIMESTAMP() AS sp_start_time);

 BEGIN
        use database curated_dev;
        let v_job_cont NUMBER  := (select count(distinct name) job_cnt from table(information_schema.task_history())
                                   where  NAME in ( ''T_PRE_STG_COMMON_TALEND_JOBS_VALIDATION'', ''T_LOAD_STG_COMMON_DATA'',''T_LOAD_PRE_STG_COMMON_DATA'')
                                    AND to_char(completed_time,''YYYY-MM-DD'') = current_date() 
                                    and state = ''SUCCEEDED'');
        let sp_end_time timestamp := (SELECT LEFT(CURRENT_TIMESTAMP(),23) AS sp_end_time);
        let sp_execution_status varchar := ''SUCCESS'';
        let sp_log_message varchar := ''Success! log inserted.'';
        let error_message varchar := ''failed! log inserted.'';
        let sp_execution_time NUMBER := (SELECT  DATEDIFf(SECOND, :sp_start_time, :sp_end_time) AS exec_time);
        
       if (v_tot_cont>=455 and v_job_cont<3) then 
        call  SNOWFLAKE_USGBC.META.SP_LOG_INFORMATION(:sp_proc_name, :sp_start_time, :sp_end_time,:sp_execution_time,:sp_execution_status, :sp_log_message );
        CALL  SNOWFLAKE_USGBC.META.SP_SEND_NOTIFCATIONS( ''Success: Procedure 01: ''||:sp_proc_name ,''Procedure successfully executed.Success! log inserted.'') ;
          return ''SUCCESS'';
        else RAISE v_all_tables_not_success;
        end if;

    EXCEPTION
      WHEN OTHER THEN
        LET error_message varchar := ''Error Details: ''||SQLSTATE||'':''||SQLCODE||'':''||SQLERRM;
        sp_execution_status := ''FAILED'';
        sp_end_time := (SELECT LEFT(CURRENT_TIMESTAMP(),23) AS sp_end_time);
        sp_execution_time  := (SELECT  DATEDIFf(SECOND, :sp_start_time, :sp_end_time) AS exec_time);
       // send email notification
       CALL  SNOWFLAKE_USGBC.META.SP_SEND_NOTIFCATIONS( ''Error in Procedure ''||:sp_proc_name ,:error_message) ;
       call  SNOWFLAKE_USGBC.META.SP_LOG_INFORMATION(:sp_proc_name, :sp_start_time, :sp_end_time,:sp_execution_time,:sp_execution_status, :error_message);
       RAISE;

 END';