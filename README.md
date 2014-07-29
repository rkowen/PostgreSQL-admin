# PostgreSQL-admin
================

A phpPgAdmin Docker image build directory that links to the "official" PostgreSQL image container.

This repository is a Docker image build directory maintained
by R.K. Owen, Ph.D. <rk@owen.sj.ca.us>

It's assumed you have some passing knowledge of Docker containers and how
to use them.  If not then browse http://docs.docker.com/ and try them
out for yourself.

Also it's assumed some knowledge of the PostgreSQL relational database and
its tools.

The PostgreSQL-* images rely on the "official" PostgreSQL Docker image,
which should be downloaded to your local set of images with:

```
	docker pull postgres:9.3.4
```

Run this image with something like this:

```
	docker run --name pgsql-server --detach=true postgres:9.3.4
```

To directly access the PostreSQL database from the commandline tool then
do the following:

```
	docker run -it --link pgsql-server:postgres			\
		--rm --name pgsql-client				\
		postgres:9.3.4						\
		sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'
```

With this you can query the database, create new users (roles) or databases,
or spawn an interactive shell to poke around the OS.

## PostgreSQL-admin

You will need to run the postgres-prep docker image to create a user and
database.
Or you can use the above pgsql-client container and create a user
with

```
CREATE USER docker WITH SUPERUSER PASSWORD 'somepassword';
CREATE DATABASE docker WITH OWNER=docker;
```

The _postgres_  default user can not be connected to over a network port, so
another user needs to be created for you to connect with.

A container can be started pointing the localhost port 4080 to port 80 (http)
of the container.  Use can use whatever localhost port you want.

```
docker run --name pgsql-admin                                           \
        --link pgsql-server:pgsql                                       \
        --detach=true                                                   \
        --publish=4080:80                                               \
        pgsql-admin:9.3.4
```
