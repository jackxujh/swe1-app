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

# Build, push and prepare for release

heroku container:push web -a $DEPLOYMENT_APP
heroku container:release web -a $DEPLOYMENT_APP

heroku run -a $DEPLOYMENT_APP 'sh -c ./scripts/init_release.sh'

# Quick Test of the new deployment

curl -f -I "http://$DEPLOYMENT_APP.herokuapp.com/polls/"