#!/bin/bash

# Collect staticfiles
python3 manage.py collectstatic --no-input
python3 manage.py makemigrations
python3 manage.py migrate

# Run the development server
DEBUG=True python3 manage.py runserver
