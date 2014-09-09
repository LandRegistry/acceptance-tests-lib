Given(/^I have got married and I want to change my name on the register$/) do
  $data = Hash.new()
  $data['newName'] = fullName()
  $data['partnerFullName'] = fullName()
  $data['dateOfMarriage'] = dateInThePast().strftime("%d-%m-%Y")
  $data['propertyPostcode'] = postcode()
  $data['locationOfMarriage'] = townName()
  $data['countryOfMarriage'] = countryName()
  $data['marriageCertificateNumber'] = certificateNumber()
  $data['witnessFullName'] = fullName()
  $data['witnessAddress'] = houseNumber().to_s + ' ' + roadName() + "\n" + townName() + "\n" + postcode()
  $data['dateSubmitted'] = Date.today.strftime("%d %B %Y").to_s
end

Given(/^I want to request I change my name on the register$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}/edit/title.proprietor.1")
end

Given(/^I own the property$/) do
  link_title_to_email($userdetails['email'], $regData['title_number'], 'CITIZEN')
end

Given(/^I don't own the property$/) do
  # Don't do anything.
end

When(/^I enter a new name$/) do
  fill_in('proprietor_new_full_name', :with => $data['newName'])
end

When(/^I enter my partners name$/) do
  fill_in('partner_name', :with => $data['partnerFullName'])
end

When(/^I enter my date of marriage$/) do
  fill_in('marriage_date', :with => $data['dateOfMarriage'])
end

When(/^I enter "(.*?)" as the Country of marriage$/) do |country|
  $data['countryOfMarriage'] = country
  select(country, :from => "marriage_country")
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
  step "I have got married and I want to change my name on the register"
  step "I have a registered property"

  $data['countryOfMarriage'] = 'GB'

  submit_changeOfName_request($data)
end

Given(/^a change of name by marriage application that requires checking$/) do
  step "I have got married and I want to change my name on the register"
  step "I have a registered property"

  $data['countryOfMarriage'] = 'AU'

  submit_changeOfName_request($data)
end






Given(/^I am the proprietor of a registered title$/) do
  step "I have a registered property with characteristics", ''
  step "I have private citizen login credentials"
  link_title_to_email($userdetails['email'], $regData['title_number'], 'CITIZEN')
end

When(/^I provide details of my change of name by marriage$/) do
  $data = Hash.new()
  $data['newName'] = fullName()
  $data['partnerFullName'] = fullName()
  $data['dateOfMarriage'] = dateInThePast().strftime("%d-%m-%Y")
  $data['propertyPostcode'] = postcode()
  $data['locationOfMarriage'] = townName()
  $data['countryOfMarriage'] = "United Kingdom"
  $data['marriageCertificateNumber'] = certificateNumber()
  $data['witnessFullName'] = fullName()
  $data['witnessAddress'] = houseNumber().to_s + ' ' + roadName() + "\n" + townName() + "\n" + postcode()
  $data['dateSubmitted'] = Date.today.strftime("%d %B %Y").to_s

  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}/edit/title.proprietor.1")
  step "I login with correct credentials"
  fill_in('proprietor_new_full_name', :with => $data['newName'])
  fill_in('partner_name', :with => $data['partnerFullName'])
  fill_in('marriage_date', :with => $data['dateOfMarriage'])
  fill_in('marriage_place', :with => $data['locationOfMarriage'])
  select($data['countryOfMarriage'], :from => "marriage_country")
  fill_in('marriage_certificate_number', :with => $data['marriageCertificateNumber'])
  click_button('Submit')
end

Then(/^the details of my change of name by marriage request are reflected back to me in a statement$/) do
  dateOfMarriage = Date.strptime($data['dateOfMarriage'], "%d-%m-%Y")
  formattedDate = dateOfMarriage.strftime("%d %B %Y").to_s

  text1 = "I confirm that I, #{$data['newName']}, was married to #{$data['partnerFullName']} on #{formattedDate} in #{$data['locationOfMarriage']}, GB."
  assert_match(text1, page.body, 'Expected to see confirmation message with marriage details')

  text2 = "The information I provide in this application will be used to change the name on registered title number #{$regData['title_number']}."
  assert_match(text2, page.body, 'Expected to see message with title number')

  assert_match('Confirm', page.body, 'Expected to certify statement including personnal details')
end

When(/^I confirm the statement reflecting my change of name by marriage is accurate and submit it$/) do
    check('confirm')
    click_button('Submit')
end

Then(/^I receive an acknowledgement my request has been sent to Land Registry$/) do
  assert_match('Application complete', page.body, 'Expected Application complete')
end

When(/^I submit my change of name by way of marriage details without entering any information$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}/edit/title.proprietor.1")
  step "I login with correct credentials"
  click_button('Submit')
end

When(/^I do not confirm the statement reflecting my change of name by marriage is accurate and submit it$/) do
  click_button('Submit')
end

Given(/^I am not the proprietor$/) do

end

When(/^I try to make a change of name by marriage request for the title$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}/edit/title.proprietor.1")
  step "I login with correct credentials"
end
