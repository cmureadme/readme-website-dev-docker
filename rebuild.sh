#!/bin/bash

set -e

# Remove old dev image
docker rmi readme-website-dev:latest || true

# Rebuild
docker build -t readme-website-dev:latest --build-arg sample_db="vol3" .

# Run
docker run --rm -ti -p 8000:8000 readme-website-dev:latest "$@"
