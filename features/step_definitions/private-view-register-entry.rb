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
