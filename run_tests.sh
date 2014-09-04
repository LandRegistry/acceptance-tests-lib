#!/bin/bash

set -e
mkdir -p /vagrant/logs

function create_test_data {
  export OS_API_KEY=NOKEY
  cd ../service-frontend
  ./create-user-for-integration-tests.sh 
  cd ../casework-frontend
  ./create-user-for-integration-tests.sh  
  cd ../matching
  ./create_test_data.sh
}

if [[ ! -f /vagrant/logs/acceptance-tests.log ]]; then
    echo "Creating required test data in apps"
    create_test_data > /vagrant/logs/acceptance-tests.log 2>&1
    cd ../acceptance-tests
fi

bundle install

if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed
else
    cucumber -r features $1
fi
