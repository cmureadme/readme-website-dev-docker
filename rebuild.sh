#! /bin/bash

# no flags to just rebuild the python part
# -b to run with bash
# -r to rebuild everything

# True if -b flag is passed
using_bash=false

# True if the -r flag is passed
rebuild_all=false

# Parse options
while getopts "br" opt; do
  case $opt in
    b)
      using_bash=true
      ;;
    r)
      rebuild_all=true
      ;;
    \?)
      echo "Usage: $0 [-b] [-r]"
      exit 1
      ;;
  esac
done

# Make script terminate on error
set -e

# Go into website folder and do manage.py stuff
cd readme-website
python3 manage.py makemigrations
python3 manage.py migrate

cd ..

# Do Docker rebuilding
if [ "$rebuild_all" = true ]; then
  docker build --tag readme-website-dev . --build-arg REBUILD=true
else
  docker build --tag readme-website-dev .
fi

yes | docker image prune 

# Deploy new build
if [ "$using_bash" = true ]; then
  docker run --rm -ti -p 8000:8000 readme-website-dev:latest bash
else
  docker run --rm -ti -p 8000:8000 readme-website-dev:latest
fi

