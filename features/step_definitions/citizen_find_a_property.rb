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
