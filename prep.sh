#!/usr/bin/env sh

cd "${0%/*}"
scriptDir="$(pwd)"

set -e

. ./vars.sh

# prove that scripts have been copied into the current docker context
ls -lsa /app

docker pull $sharedResourcesImage

docker volume rm $scripts_vol > /dev/null 2>&1 || true
docker volume create $scripts_vol
docker run \
    --name=task_loader \
    --rm \
    -v /app:/app \
    -v $scripts_vol:/out \
    -t $sharedResourcesImage \
    /bin/sh -c "cp -r /app/*.sh /out && ls -lsa /out"
