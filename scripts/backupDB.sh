#!/bin/bash

function getEnvVar() {
	echo "$(grep "$1" ../../../.env | cut -d= -f2)"
}

DB_HOST=$(getEnvVar "DB_HOST")
DB_USER=$(getEnvVar "DB_USER")
DB_PASSWORD=$(getEnvVar "DB_PASSWORD")

mysqldump -h "$DB_HOST" \
	-u "$DB_USER" \
	-p"$DB_PASSWORD" \
	--port=3306 \
	--single-transaction \
	--routines \
	--triggers \
	--databases DATABASE_NAME > rds-dump.sql

sed -e '/INSERT/,/!/!d' < rds-dump.sql > inserts.sql
grep 'INSERT' inserts.sql > data.sql
rm rds-dump.sql
rm inserts.sql
