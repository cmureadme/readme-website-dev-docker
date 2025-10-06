#!/bin/bash

set -e

if [[ "$#" < 1 ]]; then
    printf 'Usage: %s [sample_db] [command]\n' "$0" >&2
fi

# Remove old dev image
docker rmi readme-website-dev:latest || true

# Rebuild
docker build -t readme-website-dev:latest --build-arg sample_db="$1" .

# Run
docker run --rm -ti -p 8000:8000 readme-website-dev:latest "${@:2}"
