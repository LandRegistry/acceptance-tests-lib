
Given(/^the app at (.*?)$/) do |app_url|
  $app_url = app_url
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
