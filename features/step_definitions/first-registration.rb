# encoding: UTF-8

Given(/^I have received an application for a first registration$/) do
  $data = Hash.new()
  $data['propertyHouseNumber'] = houseNumber()
  $data['propertyRoad'] = roadName()
  $data['propertyTown'] = townName()
  $data['propertyPostcode'] = postcode()
  $data['pricePaid'] = pricePaid()
  $data['forename1'] = firstName()
  $data['surname1'] = surname()
  $data['forename2'] = firstName()
  $data['surname2'] = surname()
end

Given(/^I want to create a Register of Title$/) do
  step "I have caseworker login credentials"
  visit("#{$CASEWORK_FRONTEND_DOMAIN}/login")
  step "I login with correct credentials"
  click_link('First registration')
  $data['titleNumber'] = find(".//input[@id='title_number']", :visible => false).value
end

When(/^I enter a Property Address$/) do
  fill_in('house_number', :with => $data['propertyHouseNumber'])
  fill_in('road', :with => $data['propertyRoad'])
  fill_in('town', :with => $data['propertyTown'])
  fill_in('postcode', :with => $data['propertyPostcode'])
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
  fill_in('first_name1', :with => $data['forename1'])
  fill_in('surname1', :with => $data['surname1'])
  $data['forename2'] = ''
  $data['surname2'] = ''
end

When(/^I enter 2 proprietors$/) do
  fill_in('first_name1', :with => $data['forename1'])
  fill_in('surname1', :with => $data['surname1'])
  fill_in('first_name2', :with => $data['forename2'])
  fill_in('surname2', :with => $data['surname2'])
end

When(/^I submit the title details$/) do
  click_button('submit')
end

Then(/^the user will be prompted again for a proprietor$/) do
  assert_selector(".//*[@id='error_first_name1']", text: /This field is required./)
  assert_selector(".//*[@id='error_surname1']", text: /This field is required./)
end

Then(/^the user will be prompted again for required address fields$/) do
  assert_selector(".//*[@id='error_town']", text: /This field is required./)
  assert_selector(".//*[@id='error_road']", text: /This field is required./)
  assert_selector(".//*[@id='error_postcode']", text: /This field is required./)
  assert_selector(".//*[@id='error_house_number']", text: /This field is required./)
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
  assert_not_equal find(".//*[@id='title_number']", :visible => false).value, '', 'There is no titleNumber!'
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
  wait_for_register_to_be_created($data['titleNumber'])

  registered_property = get_register_by_title($data['titleNumber'])

  assert_match($data['titleNumber'].to_s, registered_property, 'Title number does not match')
  assert_match($data['forename1'].to_s, registered_property, 'Forename 1 does not match')
  assert_match($data['surname1'].to_s, registered_property, 'Surname 1 does not match')
  assert_match($data['forename2'].to_s, registered_property, 'Forename 2 does not match')
  assert_match($data['surname2'].to_s, registered_property, 'Surname 2 does not match')
  assert_match($data['propertyHouseNumber'].to_s, registered_property, 'House Number does not match')
  assert_match($data['propertyTown'].to_s, registered_property, 'Town does not match')
  assert_match($data['propertyPostcode'].to_s, registered_property, 'Postcode does not match')
  assert_match($data['propertyRoad'].to_s, registered_property, 'Road does not match')

end

Then(/^Title Number is unique$/) do
  assert_equal does_title_exist($data['titleNumber']), false, "A title with " + $data['titleNumber'] + " already exists"
end

When(/^I enter a valid title extent$/) do
  fill_in('extent', :with => genenerate_title_extent(1).to_json)
end
