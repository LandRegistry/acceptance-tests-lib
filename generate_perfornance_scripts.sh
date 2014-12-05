#!/bin/bash

set -e

echo ""
echo "IMPORTANT:"
echo "This will generate performance tests from scenarios with the @performance_test_script tag. "

echo "This requires the custom version of phantomjs from http://github.com/mooreandrew/phantomjs"
echo ""

export CASEWORK_FRONTEND_DOMAIN="http://172.16.42.43:8004"
export PROPERTY_FRONTEND_DOMAIN="http://172.16.42.43:8002"
export MINT_API_DOMAIN="http://172.16.42.43:8001"
export LR_SEARCH_API_DOMAIN="http://172.16.42.43:8003"
export SYSTEM_OF_RECORD_API_DOMAIN="http://172.16.42.43:8000"
export SERVICE_FRONTEND_DOMAIN="http://172.16.42.43:8007"
export LR_FIXTURES_URL="http://172.16.42.43:8012"
export DECISION_URL="http://172.16.42.43:8009"

export GENERATE_PERFORMANCE_SCRIPT="true"

rm -rf diff2*
rm -rf tmpimg*
rm -rf sshot*

bundle install

if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed --tags @performance_test_script
else
    cucumber -r features $1
fi
