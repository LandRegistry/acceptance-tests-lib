When(/^I select the property$/) do
  fill_in('search', :with => $regData['title_number'])
  click_button('Search')
  click_button('Select this property')
end

#When(/^I am acting on behalf of my clients$/) do
#  fill_in('num_of_clients', :with => '1')
#  click_button('Next')
#end

When(/^the clients want to buy the property$/) do
  choose('Buying this property')
  click_button('Next')
end

When(/^I request to create a client relationship$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/relationship/conveyancer")
  click_link('Start now')
end

Given(/^clients have provided their details for me to act on their behalf$/) do
  $relationshipData = Hash.new()
  $relationshipData['clients'] = Array.new()
  for i in 0..0
    $relationshipData['clients'][i] = Hash.new()
    $relationshipData['clients'][i]['full_name'] = 'Walter White'
    $relationshipData['clients'][i]['date_of_birth'] = '07-09-1959'
    $relationshipData['clients'][i]['address'] = '1 High St, London, N1 4LT'
    $relationshipData['clients'][i]['telephone'] = '01752 909 878'
    $relationshipData['clients'][i]['email'] = 'client@example.org'
    $relationshipData['clients'][i]['gender'] = 'M'
  end
end

When(/^I enter the clients details$/) do
  for i in 0..0
    fill_in('full_name', :with => $relationshipData['clients'][i]['full_name'])
    fill_in('date_of_birth', :with => $relationshipData['clients'][i]['date_of_birth'])
    fill_in('address', :with => $relationshipData['clients'][i]['address'])
    fill_in('telephone', :with => $relationshipData['clients'][i]['telephone'])
    fill_in('email', :with => $relationshipData['clients'][i]['email'])
    select('M', :from => 'gender')
    click_button('Add client')
  end
end

When(/^I confirm the details entered$/) do
  click_link('Confirm details')
end

Then(/^a relationship token code is generated$/) do
  created_token = find(".//*[@class='title-flag']").text
  validate_token_format(created_token)
end

Given(/^I want to buy the property$/) do
  #dont think this is required
end

Given(/^I want to authorise my conveyancer to act on my behalf$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/relationship/client")
  click_link('Start now')
end

Given(/^I have a relationship token for a registered property$/) do
  step "a registered property"
  step "clients have provided their details for me to act on their behalf"

  #link conveyancer, title and clients together
  $link_relationship = Hash.new()
  $link_relationship['conveyancer_lrid'] = getlrid('conveyancer@example.org')
  $link_relationship['title_number'] = $regData['title_number']
  $link_relationship['clients'] = Array.new()
  $link_relationship['clients'][0] = getlrid('client1@example.org')
  $link_relationship['clients'][1] = getlrid('client2@example.org')
  $token_code = get_token_code($link_relationship)
end

Given(/^others are yet to complete conveyancer authorisation$/) do
  #Do nothing as they are not linked already
end

When(/^I enter the relationship token code$/) do
  fill_in('token', :with => $token_code)
  click_button('Submit')
end

Then(/^the relationship details are correctly presented$/) do
  #pending # express the regexp above with the code you wish you had
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

When(/^I enter an invalid relationship token code$/) do
  fill_in('token', :with => "Rubbish")
  click_button('Submit')
end

Then(/^message informing relationship token code is invalid$/) do
  pending # express the regexp above with the code you wish you had
end
