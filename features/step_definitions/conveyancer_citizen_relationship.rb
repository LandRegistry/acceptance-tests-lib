

Given(/^am acting on behalf of (\d+) buyers$/) do |client_number|


  $relationshipData = Hash.new()
  $relationshipData['title_number'] = $regData['title_number']
  $relationshipData['transaction'] = 'buyer'
  $relationshipData['clients'] = Array.new()
  for i in 0..$conveyancer_client_number -1
    $relationshipData['clients'][i] = Hash.new()
    $relationshipData['clients'][i]['full_name'] = fullName()
    $relationshipData['clients'][i]['dob_day'] = '04'
    $relationshipData['clients'][i]['dob_month'] = '08'
    $relationshipData['clients'][i]['dob_year'] = '1980'
    $relationshipData['clients'][i]['address'] = houseNumber().to_s + ', ' + roadName() + ', ' + townName() + ', ' + postcode()
    $relationshipData['clients'][i]['telephone'] = '01752 909 878'
    $relationshipData['clients'][i]['email'] = emailAddress()
  end

end

When(/^I select the property$/) do
  fill_in('search', :with => $regData['title_number'])
  click_button('Search')
  click_button('Select this property')
end

When(/^I am acting on behalf of (\d+) clients$/) do |client_number|
  $conveyancer_client_number = client_number.to_i
  fill_in('num-clients', :with => $conveyancer_client_number)
  click_button('Next')
end

When(/^the clients want to buy the property$/) do
  choose('Buying this property')
  click_button('Next')
end

When(/^I enter the clients details$/) do

  $relationshipData = Hash.new()
  $relationshipData['clients'] = Array.new()

  for i in 0..$conveyancer_client_number -1
    $relationshipData['clients'][i] = Hash.new()
    $relationshipData['clients'][i]['full_name'] = fullName()
    $relationshipData['clients'][i]['dob_day'] = '04'
    $relationshipData['clients'][i]['dob_month'] = '08'
    $relationshipData['clients'][i]['dob_year'] = '1980'
    $relationshipData['clients'][i]['address'] = houseNumber().to_s + ', ' + roadName() + ', ' + townName() + ', ' + postcode()
    $relationshipData['clients'][i]['telephone'] = '01752 909 878'
    $relationshipData['clients'][i]['email'] = emailAddress()

    fill_in('full_name', :with => $relationshipData['clients'][i]['full_name'])
    fill_in('dob-day', :with => $relationshipData['clients'][i]['dob_day'])
    fill_in('dob-month', :with => $relationshipData['clients'][i]['dob_month'])
    fill_in('dob-year', :with => $relationshipData['clients'][i]['dob_year'])
    fill_in('tel', :with => $relationshipData['clients'][i]['telephone'])
    fill_in('email', :with => $relationshipData['clients'][i]['email'])
    click_button('Add client')

  end

    #Check summary details
    click_button('Confirm details')

end


When(/^I enter my clients details$/) do
end

Then(/^a relationship token code is generated$/) do
  pending # express the regexp above with the code you wish you had
  assert_selector(".//*[@class='??????']", text: /Relationship token/)
end

Given(/^I have a relationship token for a registered property$/) do
  step "I have a registered property"
  step "am acting on behalf of 2 buyers"

  #link conveyancer, title and clients together
  $link_relationship = Hash.new()
  $link_relationship['conveyancer_lrid'] = getlrid('conveyancer@example.org')
  $link_relationship['title_number'] = $relationshipData['title_number']
  $link_relationship['clients'] = Array.new()
  $link_relationship['clients'][0] = getlrid('client1@example.org')
  $link_relationship['clients'][1] = getlrid('client2@example.org')
  $token_code = get_token_code($link_relationship)
end

Given(/^others are yet to complete conveyancer authorisation$/) do
  #Do nothing as they won't be registered
end

When(/^I request to create a client relationship$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/relationship/conveyancer")
  click_link('Start now')
end

When(/^I enter the relationship token code$/) do
  fill_in('token', :with => $token_code)
  click_button('Submit')
end

Then(/^the relationship details are correctly presented$/) do
  pending # express the regexp above with the code you wish you had
  #check page summary
  click_button('Confirm relationship')
end

When(/^the relationship is confirmed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^relationship confirmed but not completed$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^others have completed the conveyancer authorisation$/) do
  $client_to_token = Hash.new()
  $client_to_token['client_lrid'] = $link_relationship['clients'][1]
  $client_to_token['code'] = $token_code
  associate_client_with_token($client_to_token)
end

Given(/^I want to authorise my conveyancer to act on my behalf to sell the property$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^relationship confirmed and shown as completed$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid relationship token code$/) do
  fill_in('token', :with => "Rubbish")
  click_button('Submit')
end

Then(/^message informing relationship token code is invalid$/) do
  pending # express the regexp above with the code you wish you had
end
