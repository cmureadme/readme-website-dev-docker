#!/bin/bash

# Collect staticfiles
python3 manage.py collectstatic --no-input
python3 manage.py makemigrations
python3 manage.py migrate

export DJANGO_SUPERUSER_PASSWORD=him # this way the superuser can be created from the command line
python manage.py createsuperuser --username=god --email=readme@cmukgb.org --noinput

# Run the development server
DEBUG=True python3 manage.py runserver 0.0.0.0:8000
