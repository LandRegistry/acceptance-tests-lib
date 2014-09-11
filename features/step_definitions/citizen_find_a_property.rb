Given(/^I am searching for that property$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/search")
end

When(/^I enter an incorrect Title Number \(non\-matching\)$/) do
  fill_in('search', :with => '123456')
end

When(/^I search$/) do
  click_button('Search')
end

Then(/^no results are found$/) do
  assert_match('No results found', page.body, 'Expected an error message saying no results found, however this wasn\'t present')
end

When(/^I enter the exact Title Number$/) do
  fill_in('search', :with => $regData['title_number'])
end

Then(/^the citizen register is displayed$/) do
  assert_no_match(/#{$regData['proprietors'][0]['full_name']}/i, page.body, 'Expected to find no names on this register, this means it isn\'t the public register.')
end

When(/^I enter a Title Number with the same prefix$/) do
  fill_in('search', :with => 'TEST')
end

When(/^I search for the property on gov\.uk$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/search")
  fill_in('search', :with => $regData['title_number'])
  click_button('Search')
end

Given(/^I search for a property on gov\.uk that does not exist$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/search")
  fill_in('search', :with => 'xx')
  click_button('Search')
end

Then(/^I get a no results are found message$/) do
  assert_match('No results found', page.body, 'Expected an error message saying no results found, however this wasn\'t present')
end
