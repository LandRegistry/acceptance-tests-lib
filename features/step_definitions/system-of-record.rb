
Given(/^a register entry exists$/) do 
  #This inserts a register to the DB
end
	
When(/^I search by an existing titlenumber$/) do
  url = URI::encode($URL + '/titles/TN1234567')
  resp = Net::HTTP.get_response(URI.parse(url))
  $json_response = JSON.parse(resp.body);
  puts $json_response
  if resp.code!="200" then
  	raise "The response code "
  end
  puts resp.code
end

Then(/^the register is returned in JSON format$/) do
  #this will check the elements of the JSON object
end

