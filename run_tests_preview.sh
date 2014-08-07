#!/bin/bash

set -e

bundle install

export CASEWORK_FRONTEND_DOMAIN="http://casework.landregistryconcept.co.uk/"
export PROPERTY_FRONTEND_DOMAIN="http://www.gov.uk.landregistryconcept.co.uk/"
export MINT_API_DOMAIN="http://lr-mint.herokuapp.com"
export LR_SEARCH_API_DOMAIN="http://lr-search-api.herokuapp.com"
export SYSTEM_OF_RECORD_API_DOMAIN="http://lr-system-of-record.herokuapp.com"
export SERVICE_FRONTEND_DOMAIN="http://land.service.gov.uk.landregistryconcept.co.uk"
export ENVIRONMENT="preview"

if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed
else
    cucumber -r features $1
fi
