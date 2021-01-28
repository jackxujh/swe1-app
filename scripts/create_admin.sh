#!/bin/sh

export DJANGO_SUPERUSER_PASSWORD="axiomcube"
python manage.py createsuperuser --username admin --email admin@example.com --noinput
unset DJANGO_SUPERUSER_PASSWORD
