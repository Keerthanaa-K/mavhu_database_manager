### Steps to install postgres with MacOS:

`Brew install postgres`

`psql postgres`

`CREATE ROLE postgres LOGIN SUPERUSER CREATEDB;`

`\q`

`brew services start postgresql@18`

brew services starts postgres on booting.
Use this as necessary if postgres is found to be not running.


### Setting up the db:

Running the init first time

`psql -h localhost -p 5432 -U postgres -d postgres -f init.sql`

This created the schema, admin roles, grants necessary permissions.


And then, execute run_models.sh like

`sh run_models.sh`

This creates all tables and triggers.



### For ease of use and optional:

Install dbeaver (or any other db client of your choice)

Postgres connection details are as follows:
* host: localhost
* port: 5432
* db:   mavhu_db
* user: mavhu_admin
* pass: MAvHU123!
* (TODO: login without password works, inspect that)


### Quick guide for psql

\l - list dbs

\dt -  list tables.

To run commands:
psql -h localhost -p 5432 -U postgres -d mavhu_db -c "command goes here”



