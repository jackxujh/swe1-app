#!/bin/sh

black --check .
flake8 .
coverage run --source=polls manage.py test

coveralls -v