#!/bin/bash

set -e

if [ -f /vagrant/logs ];
then
  export OS_API_KEY=NOKEY
  cd ../service-frontend
  ./create-user-for-integration-tests.sh > /vagrant/logs/acceptance-tests.log 2>&1
  cd ../casework-frontend
  ./create-user-for-integration-tests.sh  >> /vagrant/logs/acceptance-tests.log 2>&1
  cd ../matching
  ./create_test_users.sh  >> /vagrant/logs/acceptance-tests.log 2>&1
  cd ../acceptance-tests
fi

bundle install

if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed
else
    cucumber -r features $1
fi
