Given(/^I have have got married and I want to change my name on the register$/) do
  $data = Hash.new()
  $data['newName'] = firstName() + ' ' + surname()
  $data['partnerFullName'] = firstName() + ' ' + surname()
  $data['dateOfMarriage'] = dateInThePast().strftime("%d-%m-%Y")
  $data['propertyPostcode'] = postcode()
  $data['locationOfMarriage'] = townName()
  $data['countryOfMarriage'] = countryName()
  $data['marriageCertificateNumber'] = certificateNumber()
  $data['witnessFullName'] = firstName() + ' ' + surname()
  $data['witnessAddress'] = houseNumber().to_s + ' ' + roadName() + "\n" + townName() + "\n" + postcode()

end

Given(/^I want to request I change my name on the register$/) do
  #visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}/edit")
  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}/edit/title.proprietor.1")
  puts "#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}/edit/title.proprietor.1"

end

When(/^I enter a new name$/) do
  fill_in('proprietor_new_surname', :with => $data['newName'])
end

When(/^I enter my partners name$/) do
  fill_in('partner_name', :with => $data['partnerFullName'])
end

When(/^I enter my date of marriage$/) do
  fill_in('marriage_date', :with => $data['dateOfMarriage'])
end

When(/^I enter GB as the Country of marriage$/) do
  $data['countryOfMarriage'] = 'GB'
  fill_in('marriage_country', :with => $data['countryOfMarriage'])
end

When(/^I do not enter GB as the Country of marriage$/) do
  $data['countryOfMarriage'] = 'Non Great Britain'
  fill_in('marriage_country', :with => $data['countryOfMarriage'])
end

When(/^I enter a location of marriage$/) do
  fill_in('marriage_place', :with => $data['locationOfMarriage'])
end

When(/^I enter a Marriage Certificate Number$/) do
  fill_in('marriage_certificate_number', :with => $data['marriageCertificateNumber'])
end

When(/^I enter a witness name$/) do
  fill_in('witness_full_name', :with => $data['witnessFullName'])
end

When(/^I enter a Witness Address$/) do
  fill_in('witness_house_number', :with => $data['witnessAddress'])
end

When(/^I submit the marriage change of name details$/) do
  click_button('Submit')
end

Then(/^I am presented to certify my details$/) do
  assert_match('Confirm', page.body, 'Expected to certify statement including personnal details')
  assert_match($data['newName'], page.body, 'Expected to certify statement including personnal details')
  assert_match($data['dateOfMarriage'], page.body, 'Expected to certify statement including personnal details')
  assert_match($data['locationOfMarriage'], page.body, 'Expected to certify statement including personnal details')
  #assert_match($data['countryOfMarriage'], page.body, 'Expected to certify statement including personnal details')
  assert_match($data['partnerFullName'], page.body, 'Expected to certify statement including personnal details')
end

Then(/^I receive a confirmation that my change of name request has been lodged$/) do
  assert_match('Application complete', page.body, 'Expected Application complete')
end

When(/^I accept the certify statement$/) do
  check('confirm')
  click_button('Submit')
end

Given(/^a change of name by marriage application that requires reviewing by a caseworker$/) do
  step "I have have got married and I want to change my name on the register"
  step "I have a registered property"
  step "I have private citizen login credentials"
  step "I want to request I change my name on the register"
  step "I am logged in"
  step "I enter a new name"
  step "I enter my date of marriage"
  step "I enter my partners name"
  step "I enter GB as the Country of marriage"
  step "I enter a location of marriage"
  step "I enter a Marriage Certificate Number"
  step "I submit the marriage change of name details"
  step "I accept the certify statement"
end

Given(/^a change of name by marriage application that requires checking$/) do
  step "I have have got married and I want to change my name on the register"
  step "I have a registered property"
  step "I have private citizen login credentials"
  step "I want to request I change my name on the register"
  step "I am logged in"
  step "I enter a new name"
  step "I enter my date of marriage"
  step "I enter my partners name"
  step "I do not enter GB as the Country of marriage"
  step "I enter a location of marriage"
  step "I enter a Marriage Certificate Number"
  step "I submit the marriage change of name details"
  step "I accept the certify statement"
end
