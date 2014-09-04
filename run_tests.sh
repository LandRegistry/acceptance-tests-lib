#!/bin/bash

set -e

function create_test_data {
  export OS_API_KEY=NOKEY
  cd ../service-frontend
  ./create-user-for-integration-tests.sh
  cd ../casework-frontend
  ./create-user-for-integration-tests.sh
  cd ../matching
  ./create_test_data.sh
}

rm -rf diff2*
rm -rf tmpimg*
rm -rf sshot*

bundle install

if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed
else
    cucumber -r features $1
fi
