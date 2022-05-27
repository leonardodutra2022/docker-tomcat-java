#!/bin/bash

PG_HOST=postgres_db
PG_USER=USER
PG_DATABASE=DATABASE
PG_CONTAINER_NAME=postgres_db_instance
PATH_AND_FILENAME=${1}


if [ "$PATH_AND_FILENAME" == "" ]; then
	echo "Type file db_backup path complete: "
	read PATH_AND_FILENAME
fi


echo "Restore database from "
echo ${PATH_AND_FILENAME}

docker exec -i ${PG_CONTAINER_NAME} pg_restore -U ${PG_USER} -v -d ${PG_DATABASE} < ${PATH_AND_FILENAME}

