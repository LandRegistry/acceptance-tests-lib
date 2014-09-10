

Given(/^am acting on behalf of (\d+) buyers$/) do |client_number|
  visit("#{$SERVICE_FRONTEND_DOMAIN}/relationship/conveyancer")
  click_button('Start now')
  $conveyancer_client_number = client_number
  $relationshipData = Hash.new()
  $relationshipData['title_number'] = $regData['title_number']
  $relationshipData['transaction'] = 'buyer'
  $relationshipData['clients'] = Array.new()
  for i in 0..client_number -1
    $relationshipData['clients'][i] = Hash.new()
    $relationshipData['clients'][i]['full_name'] = full_name()
    $relationshipData['clients'][i]['dob_day'] = '04'
    $relationshipData['clients'][i]['dob_month'] = '08'
    $relationshipData['clients'][i]['dob_year'] = '1980'
    $relationshipData['clients'][i]['address'] = houseNumber() + ', ' + roadName() + ', ' + townName() + ', ' + postcode()
    $relationshipData['clients'][i]['telephone'] = '01752 909 878'
    $relationshipData['clients'][i]['email'] = emailAddress()
  end

end

When(/^I select the property$/) do
  fill_in('search', :with => $relationshipData['title_number'])
  click_button('Search')
end

When(/^I enter my clients details$/) do
  fill_in('num-clients', :with => $conveyancer_client_number)
  click_button('Next')
  choose('radio-inline-1')
  click_button('Next')

  count = 1
  for i in 0..$conveyancer_client_number -1
    fill_in('full-name', :with => $relationshipData['clients'][i]['full_name'])
    fill_in('dob-day', :with => $relationshipData['clients'][i]['dob-day'])
    fill_in('dob_month', :with => $relationshipData['clients'][i]['dob_month'])
    fill_in('dob_year', :with => $relationshipData['clients'][i]['dob_year'])
    fill_in('tel', :with => $relationshipData['clients'][i]['telephone'])
    fill_in('email', :with => $relationshipData['clients'][i]['email'])
    click_button('Add client')
  end

  #Check summary details
  click_button('Confirm details')
end

Then(/^a relationship token code is generated$/) do
  pending # express the regexp above with the code you wish you had
  assert_selector(".//*[@class='??????']", text: /Relationship token/)
end

Given(/^I have a relationship token for a registered property$/) do
  step "am acting on behalf of 2 buyers"

  #link conveyancer, title and clients together
  $link_relationship = Hash.new()
  $link_relationship['conveyancer_lrid'] = getlrid('conveyancer@example.org')
  $link_relationship['title_number'] = $relationshipData['title_number']
  $link_relationship['clients'] = Array.new()
  $link_relationship['clients'][0] = getlrid($relationshipData['clients'][0]['email'])
  $link_relationship['clients'][1] = getlrid($relationshipData['clients'][1]['email'])

  token - /relationship/conveyancer/token
  uri = URI.parse($INTRODUCTIONS_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/relationship/',  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = $link_relationship.to_json
  response = http.request(request)
  if (response.code != '201') then
    raise "Failed creating relationship: " + response.body
  end
  $token_code = response.body

end

Given(/^others are yet to complete conveyancer authorisation$/) do
  #Do nothing as they won't be registered
end

Given(/^I want to authorise my conveyancer to act on my behalf to buy the property$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/relationship/client")
  click_button('Start now')
end

When(/^I enter the relationship token code$/) do
  #fill_in('full-name', :with => $relationshipData['clients'][i]['full_name'])
end

Then(/^the relationship details are correctly presented$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^the relationship is confirmed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^relationship confirmed but not completed$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^others have completed the conveyancer authorisation$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I want to authorise my conveyancer to act on my behalf to sell the property$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^relationship confirmed and shown as completed$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid relationship token code$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^message informing relationship token code is invalid$/) do
  pending # express the regexp above with the code you wish you had
end
