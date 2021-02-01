#!/bin/sh
set -e

TARGET=$1

# Check for deployment destination

PRODUCTION_TARGET="production"
STATING_TARGET="staging"

PRODUCTION_APP_HEROKU="swe-app-neo"
STATING_APP_HEROKU="swe-app-neo-staging"

if [ "$TARGET" = "$PRODUCTION_TARGET" ]
then
    DEPLOYMENT_APP=$PRODUCTION_APP_HEROKU
elif [ "$TARGET" = "$STATING_TARGET" ]
then
    DEPLOYMENT_APP=$STATING_APP_HEROKU
fi

echo "Will deploy to $DEPLOYMENT_APP on Heroku."

# Login, push and prepare for release

heroku auth:token
heroku container:login

heroku container:push web -a $DEPLOYMENT_APP
heroku container:release web -a $DEPLOYMENT_APP

heroku run -a $DEPLOYMENT_APP python manage.py collectstatic
heroku run -a $DEPLOYMENT_APP python manage.py migrate

# Quick Test of the new deployment

curl -f -I "http://$DEPLOYMENT_APP.herokuapp.com/polls/"