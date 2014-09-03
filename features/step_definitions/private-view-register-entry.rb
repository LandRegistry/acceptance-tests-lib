When(/^I view the private register$/) do
  #The URL is accessed directly with generated TN
  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}")
end

#public detail checks located in citizen-view-register

Then(/^Tenure is displayed$/) do
  assert_match(/#{$regData['property']['tenure']}/i, page.body, 'Expected to see tenure value')
end

Then(/^Class is displayed$/) do
  assert_match(/#{$regData['property']['class_of_title']}/i, page.body, 'Expected to see class of title value')
end

Then(/^proprietors are displayed$/) do
  assert_match(/#{$regData['proprietors'][0]['full_name']}/i, page.body, 'Expected to see proprietor name')
  if $regData['proprietors'][1]['full_name'] != "" then
    assert_match(/#{$regData['proprietors'][1]['full_name']}/i, page.body, 'Expected to see proprietor name')
  end
end

Then(/^the company charge is displayed$/) do
  assert_match(Date.parse($regData['charges'][0]['charge_date']).strftime("%d %B %Y"), page.body, 'Expected to find house_number')
  assert_match(/#{$regData['charges'][0]['chargee_address']}/i, page.body, 'Expected to find chargee_address')
  assert_match(/#{$regData['charges'][0]['chargee_name']}/i, page.body, 'Expected to find chargee_name')
  assert_match(/#{$regData['charges'][0]['chargee_registration_number']}/i, page.body, 'Expected to find chargee_registration_number')
end

Then(/^the charge restriction is NOT displayed$/) do
  restriction_text = "No disposition of the registered estate by the proprietor of the registered estate is to be registered without a written consent signed by the proprietor for the time being of the Charge dated "
  assert_no_match(/#{restriction_text}/, page.body, 'charge restriction not expected ')
end

Then(/^the charge restriction is displayed$/) do
  restriction_text = "No disposition of the registered estate by the proprietor of the registered estate is to be registered without a written consent signed by the proprietor for the time being of the Charge dated "
  restriction_text = restriction_text + Date.parse($regData['charges'][0]['charge_date']).strftime("%d %B %Y")
  restriction_text = restriction_text +  " in favour of "
  restriction_text = restriction_text +  $regData['charges'][0]['chargee_name']
  restriction_text = restriction_text + " referred to in the Charges Register."
  puts restriction_text
  assert_match(/#{restriction_text}/, page.body.gsub(/\s+/, ' '), 'expected to find charge restriction '+restriction_text)
end

Then(/^the company charge is displayed with no restriction$/) do
  step "the company charge is displayed"
  step "the charge restriction is NOT displayed"
end

Then(/^the company charge is displayed with a restriction$/) do
step "the company charge is displayed"
step "the charge restriction is displayed"
end
