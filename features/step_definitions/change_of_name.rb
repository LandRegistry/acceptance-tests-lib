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
  step "I have got married and I want to change my name on the register"
  $data['countryOfMarriage'] = 'United Kingdom'
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
