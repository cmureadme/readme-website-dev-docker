#!/bin/bash

set -e

if [[ "$#" < 1 ]]; then
    printf 'Usage: %s SAMPLE_DB [command]\n' "$0" >&2
    exit 1
fi

# Remove old dev image
printf 'Removing old image...\n'
docker rmi readme-website-dev:latest || true

# Rebuild
docker build -t readme-website-dev:latest --build-arg sample_db="$1" .

# Run
docker run --rm -ti -p 8000:8000 readme-website-dev:latest "${@:2}"
