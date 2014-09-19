When(/^I select the property$/) do
  fill_in('search', :with => $regData['title_number'])
  click_button('Search')
  click_button('Select this property')
end

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

  $relationshipData['clients'] = Hash.new()
  $relationshipData['clients']['full_name'] = 'Walter White'
  $relationshipData['clients']['date_of_birth'] = '07-09-1959'
  $relationshipData['clients']['address'] = '1 High St, London, N1 4LT'
  $relationshipData['clients']['telephone'] = '01752 909 878'
  $relationshipData['clients']['email'] = 'citizen@example.org'
  $relationshipData['clients']['gender'] = 'M'
end

When(/^I enter the clients details$/) do
  fill_in('full_name', :with => $relationshipData['clients']['full_name'])
  fill_in('date_of_birth', :with => $relationshipData['clients']['date_of_birth'])
  fill_in('address', :with => $relationshipData['clients']['address'])
  fill_in('telephone', :with => $relationshipData['clients']['telephone'])
  fill_in('email', :with => $relationshipData['clients']['email'])
  select($relationshipData['clients']['gender'], :from => 'gender')
  click_button('Add client')
end

When(/^I confirm the details entered$/) do
  click_link('Confirm details')
end

Then(/^a relationship token code is generated$/) do
  created_token = find(".//*[@class='title-flag']").text
  validate_token_format(created_token)
end

Given(/^I want to authorise my conveyancer to act on my behalf$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}")
  step "I login with correct credentials"
  click_link('Confirm a relationship')
end

Given(/^I have a relationship token for a registered property$/) do
  step "a registered title"

  $link_relationship = Hash.new()
  $link_relationship['conveyancer_lrid'] = getlrid('conveyancer@example.org')
  $link_relationship['title_number'] = $regData['title_number']
  $link_relationship['conveyancer_name'] = 'Tuco Salamanca'
  $link_relationship['conveyancer_address'] = '123 Bad Place, Rottentown, ABC 123'
  $link_relationship['clients'] = Array.new()
  $link_relationship['clients'][0] = Hash.new()
  $link_relationship['clients'][0]['lrid'] = getlrid('citizen@example.org')
  $link_relationship['title_number'] = $regData['title_number']
  $link_relationship['task'] = 'sell'

  $token_code = get_token_code($link_relationship)
  puts $token_code
end

When(/^I enter the relationship token code$/) do
  fill_in('token', :with => $token_code)
  click_button('Submit')
end

When(/^I enter an invalid relationship token code$/) do
  fill_in('token', :with => "Rubbish")
  click_button('Submit')
end

Then(/^message informing relationship token code is invalid is displayed$/) do
  assert_match(/Bad Request/i, page.body, 'Expected to get invalid error message')
end

When(/^I confirm the relationship$/) do
    check('check-1')
    click_button('Confirm relationship')
end

Then(/^the relationship is confirmed$/) do
  assert_match(/You have confirmed your relationship/i, page.body, 'Expected to get message saying the relationship was confirmed')
end
