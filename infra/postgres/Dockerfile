FROM postgres:12 as postgresdb

ENV POSTGRES_USER="USER_DEFAULT"

ENV POSTGRES_PASSWORD="PASS_DEFAULT"

ENV POSTGRES_DB="DATABASE"

ENV PGDATA="/data/postgres"

RUN apt-get update && apt-get install -y postgresql-contrib

# COPY extensions/* /docker-entrypoint-initdb.d/

# RUN chmod 755 /docker-entrypoint-initdb.d/*