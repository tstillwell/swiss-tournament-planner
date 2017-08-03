# Swiss Tournament Planner #

_______________________________________________________

A simple, normalized database schema for PostgreSQL.

Stores players, matches, and rankings for a Swiss-Style tournament,
built for Postgress databases.

Swiss tournaments are tournaments where every player
gets to play in the same number of rounds and players
play against others with a similar win rate.

See https://en.wikipedia.org/wiki/Swiss-system_tournament

To set up the database, first create a database called
`tournament`

`psql ->create database tournament;`

Then connect to the database

`psql ->\connect tournament`

Once that is done, import the database definitions.

`tournament ->\i tournament.sql`

Now, exit the psql interactive terminal
and run the unit tests to confirm everything is working

`python tournament_test.py`

If all is well you should see
`"Success!  All tests pass!"`


## Setup

There are three pieces of software
required for the schema.

PostgreSQL, Python2, and Psycopg2


For Python see
https://docs.python.org/2/using/index.html

Once you have Python installed you need
psycopg2, a database adapter so python
can interface with the Postgres database.

http://initd.org/psycopg/docs/install.html

See the section below for installing Postgres

##### Getting Postgres installed
First, you need a PostgreSQL RDBMS installed on your system.
You need root/super-user/admin privelages.

Follow the install guide to get the database installed
https://wiki.postgresql.org/wiki/Detailed_installation_guides

Once you have it installed, you can verify the installation
by running the `psql` command in your terminal/command prompt.

You should get a prompt that shows something like

`psql ->`

That means you are in the PostgreSQL interactive terminal.

##### Creating tournament database

Once you have the psql prompt, you'll need to create
an empty `tournament` database.

The database connection in the Python code looks
for a database named `tournament`, but this name can
be changed by modifying the `dbname` keyword
in the connect function in `tournament.py`

`dbname=tournament`

`psql ->create database tournament;`

You should get some output that shows:
`CREATE DATABASE`

This means the creation was successful.

##### Connecting to the database

The python code connects to the database using
the connect function.

There are SQL table definitions that have to be
imported into the database so the underlying tables
can be created. This only has to be done once.

To do this, connect to the database, either by
using the psql command from the prompt

`psql tournament`

or if already in the psql interactive shell:

`psql -> \connect tournament`

And you'll see

`tournament->`

##### Creating tables

Now that you're connected to the database the
definitions should be imported

`tournament-> \i tournament.sql`

You should see
`CREATE TABLE`

and

`CREATE VIEW`

Then you should be done setting up the database.
Quit from the interactive shell with `\q`

##### Testing the Schema

Now the schema is set up successfully,
you can test it using the unit test script

`python tournament_test.py`

If all the tests pasts you should see
the test messages and

`"Success!  All tests pass!"`

If you see that, the schema is working properly.

You can use it either by

using the python functions in
`tournament.py`

or by using your own SQL.

## Built with help from

### PostgreSQL

PostgreSQL Database Management System

Portions Copyright (c) 1996-2017, The PostgreSQL Global Development Group

Portions Copyright (c) 1994, The Regents of the University of California

http://www.postgresql.org/about/

https://www.postgresql.org/about/licence/

### Python 2

https://www.python.org/

https://docs.python.org/2/license.html

### psycopg2

Python-PostgreSQL Database Adapter

http://initd.org/psycopg/license/

https://github.com/psycopg/psycopg2
