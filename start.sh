#!/usr/bin/env bash
# run this file on your local machine to kick off the example

set -e

docker build -f Prep.dockerfile -t prep .
docker run \
    -v /var/run/docker.sock:/var/run/docker.sock \
    prep
