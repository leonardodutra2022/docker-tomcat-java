#!/bin/bash

PG_HOST=postgres_db
PG_USER=USER
PG_DATABASE=DATABASE
PG_CONTAINER_NAME=postgres_db_instance
FILENAME=dumpname.backup


docker exec -i ${PG_CONTAINER_NAME} pg_dump -h ${PG_HOST} --clean --format=c --file=/tmp/${FILENAME} --username=${PG_USER} ${PG_DATABASE}

