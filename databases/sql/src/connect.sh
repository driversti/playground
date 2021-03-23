#!/usr/bin/env bash
# running in parallel with the command below
# there is printed a message in a console that the template cannot be parsed because it doesn't exist
# until [[ $(docker inspect -f {{.State.Running}} postgres) == "true" ]]; do sleep 0.1; done
docker exec -it postgres psql -h localhost -U postgres -d playground
