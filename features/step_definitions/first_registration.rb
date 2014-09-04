# encoding: UTF-8

Given(/^I have received an application for a first registration$/) do
  $regData = nil
  $data = Hash.new()
  $data['address_line_1'] = houseNumber()
  $data['address_line_2'] = roadName()
  #$data['address_line_3'] = roadName()
  #$data['address_line_4'] = roadName()
  $data['city'] = townName()
  $data['postcode'] = postcode()
  $data['pricePaid'] = pricePaid()
  $data['fullName1'] = fullName()
  $data['fullName2'] = fullName()
  $data['title_extent'] = genenerate_title_extent2({'has a polygon with easement' => true})
  $data['easement'] = genenerate_title_easement2({'has a polygon with easement' => true})
end

Given(/^I want to create a Register of Title$/) do
  step "I have caseworker login credentials"
  visit("#{$CASEWORK_FRONTEND_DOMAIN}")
  step "I login with correct credentials"
  click_link('First registration')
  $data['titleNumber'] = find(".//input[@id='title_number']", :visible => false).value
end

When(/^I enter a Property Address$/) do
  fill_in('address_line_1', :with => $data['address_line_1'])
  fill_in('address_line_2', :with => $data['address_line_2'])
  #fill_in('address_line_3', :with => $data['address_line_3'])
  #fill_in('address_line_4', :with => $data['address_line_4'])
  fill_in('city', :with => $data['city'])
  fill_in('postcode', :with => $data['postcode'])
end

When(/^I choose a tenure of Freehold$/) do
  choose('Freehold')
end

When(/^I choose a tenure of Leasehold$/) do
  choose('Leasehold')
end

When(/^I select class of Absolute$/) do
  choose('Absolute')
end

When(/^I enter a valid price paid$/) do
  fill_in('price_paid', :with => $data['pricePaid'])
end

When(/^I enter 1 proprietor$/) do
  fill_in('full_name1', :with => $data['fullName1'])
  $data['fullName2'] = ''
end

When(/^I enter 2 proprietors$/) do
  fill_in('full_name1', :with => $data['fullName1'])
  fill_in('full_name2', :with => $data['fullName2'])
end

When(/^I submit the title details$/) do
  click_button('submit')
end

When(/^I submit the title details without entering any data$/) do
  click_button('submit')
end

Then(/^the user will be prompted again for a proprietor$/) do
  assert_selector(".//*[@id='error_full_name1']", text: /This field is required./)
end

Then(/^the user will be prompted again for required address fields$/) do
  assert_selector(".//*[@id='error_address_line_1']", text: /This field is required./)
  assert_selector(".//*[@id='error_postcode']", text: /This field is required./)
  assert_selector(".//*[@id='error_city']", text: /This field is required./)
end

When(/^I select class of Good$/) do
  choose('Good')
end

When(/^I select class of Possessory$/) do
  choose('Possessory')
end

When(/^I select class of Qualified$/) do
  choose('Qualified')
end

When(/^I enter an invalid price paid$/) do
  $data['pricePaid'] = "@£$%^&*Broken10"
  fill_in('price_paid', :with => $data['pricePaid'])
end

Then(/^a Title Number is displayed$/) do
  assert_match(/#{$regData['title_number']}/i, page.body, 'Expected to see title number')
end

Then(/^Title Number is formatted correctly$/) do
  titleNumber = find(".//*[@id='title_number']", :visible => false).value

  assert_equal titleNumber[0,4], 'TEST', 'Title does not have a prefix of TEST'
  assert_equal titleNumber[4,titleNumber.size - 1], titleNumber[4,titleNumber.size - 1].to_i.to_s, 'The title number is not numberic'
  assert_operator titleNumber[4,titleNumber.size - 1].to_i, :>=, 1, 'The number is less than 0'
  assert_operator titleNumber[4,titleNumber.size - 1].to_i, :<=, 99999, 'The number is greater than 99999'

end

Then(/^I have received confirmation that the property has been registered$/) do
  assert_match(/New title created/i, page.body, 'Expected registration message but was not present')

  registered_property = wait_for_register_to_be_created($data['titleNumber'])

  assert_match($data['titleNumber'].to_s, registered_property, 'Title number does not match')
  assert_match($data['fullName1'].to_s, registered_property, 'FullName 1 does not match')
  assert_match($data['fullName2'].to_s, registered_property, 'FullName 2 does not match')
  assert_match($data['propertyHouseNumber'].to_s, registered_property, 'House Number does not match')
  assert_match($data['propertyTown'].to_s, registered_property, 'Town does not match')
  assert_match($data['propertyPostcode'].to_s, registered_property, 'Postcode does not match')
  assert_match($data['propertyRoad'].to_s, registered_property, 'Road does not match')

end

Then(/^Title Number is unique$/) do
  assert_equal does_title_exist($data['titleNumber']), false, "A title with " + $data['titleNumber'] + " already exists"
end

When(/^I enter a valid title extent$/) do
  fill_in('extent', :with => $data['title_extent'].to_json)
end

Then(/^a \"([^\"]*)\" message for \"([^\"]*)\" is returned$/) do |errorMessage, fieldId|
  assert_selector(".//*[@id='" + fieldId + "']", text: errorMessage)
end

Given(/^I enter a price paid with too many decimal places$/) do
  $data['pricePaid'] = "100.00001"
  fill_in('price_paid', :with => $data['pricePaid'])
end

When(/^I enter (\d+) company charges$/) do |arg1|
  click_button('Add a charge')
  todayDate =  Date.today.strftime("%d-%m-%Y")
  fill_in('charges-0-charge_date', :with => todayDate)
  fill_in('charges-0-chargee_name', :with => "Fake company1")
  fill_in('charges-0-chargee_registration_number', :with => "Test reg no1")
  fill_in('charges-0-chargee_address', :with => "Flat 3, 2 Test Street, London, SE17 3BY")

  click_button('Add a charge')

  yesterdayDate =  Date.today.prev_day.strftime("%d-%m-%Y")
  fill_in('charges-1-charge_date', :with => yesterdayDate)
  fill_in('charges-1-chargee_name', :with => "Fake company2")
  fill_in('charges-1-chargee_registration_number', :with => "Test reg no2")
  fill_in('charges-1-chargee_address', :with => "21 Test Street, London, SE17 3BY")
end

Given(/^I add a charge with no information$/) do
  click_button('Add a charge')
end

When(/^I enter valid Date of Lease$/) do
  yesterdayDate =  Date.today.prev_day.strftime("%d-%m-%Y")
  fill_in('leases-0-lease_date', :with => yesterdayDate)
end

When(/^I enter valid Term Years$/) do
  fill_in('leases-0-lease_term', :with => '7')
end

When(/^I enter valid term start date$/) do
  todayDate =  Date.today.strftime("%d-%m-%Y")
  fill_in('leases-0-lease_from', :with => todayDate)
end

When(/^I enter Lessor name$/) do
  lessor_name = fullName()
  fill_in('leases-0-lessor_name', :with => lessor_name)
end

When(/^I enter proprietor as lessee name$/) do
  proprietor_lessee_name = $data['fullName1']
  fill_in('leases-0-lessee_name', :with => proprietor_lessee_name)
end

When(/^I enter non proprietor lessee name$/) do
  lessee_name = fullName() + 'diff '
  fill_in('leases-0-lessee_name', :with => lessee_name)
end

When(/^I select easement within lease$/) do
  check('leases-0-lease_easements')
end

When(/^I select alienation$/) do
  check('leases-0-alienation_clause')
end

When(/^I select landlords title registered$/) do
  check('leases-0-title_registered')
end

When(/^I enter a valid title easement$/) do
  click_button('Add an easement')
  fill_in('easements-0-easement_description', :with => 'Easement Description')
  fill_in('easements-0-easement_geometry', :with => $data['easement'].to_json)
end
