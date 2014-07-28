#!/bin/bash

export CASEWORK_FRONTEND_DOMAIN="http://lr-casework-frontend.herokuapp.com"
export SEARCH_FRONTEND_DOMAIN="http://lr-property.herokuapp.com"
export PROPERTY_FRONTEND_DOMAIN="http://lr-property-frontend.herokuapp.com"
export MINT_API_DOMAIN="http://lr-mint.herokuapp.com"
export PUBLICTITLE_API_DOMAIN="http://lr-public-titles-api.herokuapp.com"
export LR_SEARCH_API_DOMAIN="http://lr-search-api.herokuapp.com"
export SYSTEM_OF_RECORD_API_DOMAIN="http://lr-system-of-record.herokuapp.com"
cucumber --tags ~@wip --tags ~@removed
