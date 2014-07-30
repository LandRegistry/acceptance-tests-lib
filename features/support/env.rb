
require 'w3c_validators'

include W3CValidators

$CASEWORK_FRONTEND_DOMAIN = (ENV['CASEWORK_FRONTEND_DOMAIN'] || 'http://lr-dev:8004')
$PROPERTY_FRONTEND_DOMAIN = (ENV['PROPERTY_FRONTEND_DOMAIN'] || 'http:/lr-dev:8002') # not sure of local address yet
$MINT_API_DOMAIN = (ENV['MINT_API_DOMAIN'] || 'http://lr-dev:8001') # not sure of local address yet
$SERVICE_FRONTEND_DOMAIN=(ENV['SERVICE_FRONTEND_DOMAIN'] || 'http://lr-dev:8007')
$LR_SEARCH_API_DOMAIN=(ENV['LR_SEARCH_API_DOMAIN'] || 'http://lr-dev:8003')
$SYSTEM_OF_RECORD_API_DOMAIN=(ENV['SYSTEM_OF_RECORD_API_DOMAIN'] || 'http://lr-dev:8000')
