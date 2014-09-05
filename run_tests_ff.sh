#!/bin/bash

set -e



export CASEWORK_FRONTEND_DOMAIN="http://172.16.42.43:8004"
export PROPERTY_FRONTEND_DOMAIN="http://172.16.42.43:8002"
export MINT_API_DOMAIN="http://172.16.42.43:8001"
export LR_SEARCH_API_DOMAIN="http://172.16.42.43:8003"
export SYSTEM_OF_RECORD_API_DOMAIN="http://172.16.42.43:8000"
export SERVICE_FRONTEND_DOMAIN="http://172.16.42.43:8007"
export LR_FIXTURES_URL="http://172.16.42.43:8012"
export DECISION_URL="http://172.16.42.43:8009"

if [ -f /vagrant/logs ];
then
  cd ../service-frontend
  ./create-user-for-integration-tests.sh > /vagrant/logs/acceptance-tests.log 2>&1
  cd ../casework-frontend
  ./create-user-for-integration-tests.sh  >> /vagrant/logs/acceptance-tests.log 2>&1
  cd ../acceptance-tests
fi

bundle install

export WEBDRIVER="Firefox"

if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed
else
    cucumber -r features $1
fi
