#!/bin/sh

black --check .
flake8 .
python manage.py makemigrations
python manage.py migrate
coverage run --source=polls manage.py test

coveralls