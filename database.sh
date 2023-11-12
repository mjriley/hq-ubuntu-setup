#!/usr/bin/env bash
read -r DB_NAME DB_USER DB_PASS < <(python -c 'import localsettings; db=localsettings.DATABASES["default"]; print("{} {} {}".format(db["NAME"], db["USER"], db["PASSWORD"]))')
PGPASSWORD="$DB_PASS" psql -h localhost -p 5432 -U "$DB_USER" -c "CREATE DATABASE commcarehq;"

./manage.py sync_couch_views
./manage.py create_kafka_topics
env CCHQ_IS_FRESH_INSTALL=1 ./manage.py migrate --noinput

