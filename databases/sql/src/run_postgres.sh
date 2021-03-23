#!/usr/bin/env bash
docker run --rm --name postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=playground \
  -v "$PWD/initial_data.sql":/docker-entrypoint-initdb.d/init.sql \
  -p 5432:5432 \
  -ti postgres
