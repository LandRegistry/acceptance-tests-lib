
Given(/^the app at (.*?)$/) do |app|
  case app
  when 'lr-system-of-record'    then $app_url = $SYSTEM_OF_RECORD_API_DOMAIN
  when 'lr-casework-frontend'   then $app_url = $CASEWORK_FRONTEND_DOMAIN
  when 'lr-property-frontend'   then $app_url = $PROPERTY_FRONTEND_DOMAIN
  when 'lr-mint'                then $app_url = $MINT_API_DOMAIN
  when 'lr-search-api'          then $app_url = $LR_SEARCH_API_DOMAIN
  when 'lr-service-frontend'    then $app_url = $SERVICE_FRONTEND_DOMAIN
  else
    raise 'Invalid app ' + app
  end
end

When(/^I GET to (\/\S*?)$/) do |app_path|
  uri = URI.parse($app_url)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(app_path,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  $app_response = http.request(request)
end

Then(/^I should get a (\d+) status code$/) do |resonse_code|
  assert_equal $app_response.code.to_i, resonse_code.to_i, 'The response codes do not match'
end
