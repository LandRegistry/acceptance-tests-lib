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
  cd ../acceptance-tests
}

rm -rf diff2*
rm -rf tmpimg*
rm -rf sshot*

bundle install

if [[ ! -f /vagrant/logs/acceptance-tests.data ]]; then
	echo "Creating test data"
	create_test_data 
        touch /vagrant/logs/acceptance-tests.data	
fi


if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed
else
    cucumber -r features $1
fi
