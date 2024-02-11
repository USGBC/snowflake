# liquibase-snowflake
Liquibase-snowflake


liquibase status --changelog-file=/dbscripts/masterChangelog.xml --url="jdbc:snowflake://${orgname}-${account_id}.snowflakecomputing.com/?db=${db.name}&schema=${db.schema}&role=${db.role}&warehouse=${db.warehouse}" --username=${db.username} --password=${db.password}

liquibase update --changelog-file=/dbscripts/masterChangelog.xml --url="jdbc:snowflake://${orgname}-${account_id}.snowflakecomputing.com/?db=${db.name}&schema=${db.schema}&role=${db.role}&warehouse=${db.warehouse}" --username=${db.username} --password=${db.password}
