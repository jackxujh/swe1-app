#!/bin/sh

black --check .
flake8 .
python manage.py makemigrations
sh -c ./scripts/init_release.sh
coverage run --source=polls manage.py test

coveralls