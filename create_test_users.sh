#!/bin/bash

set -e

export OS_API_KEY=NOKEY
cd ../service-frontend
./create-user-for-integration-tests.sh
cd ../casework-frontend
./create-user-for-integration-tests.sh
cd ../matching
./create_test_data.sh
cd ../acceptance-tests
