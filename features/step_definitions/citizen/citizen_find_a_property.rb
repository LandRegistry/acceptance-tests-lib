When(/^I search for the property on gov\.uk$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/search")
  fill_in('search', :with => $regData['title_number'])
  main = page.all(:xpath, ".//main")
  main[0].find_button('Search').click
end

Given(/^I search for a property on gov\.uk that does not exist$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/search")
  fill_in('search', :with => 'xx')
  main = page.all(:xpath, ".//main")
  main[0].find_button('Search').click
end

Then(/^I get a no results are found message$/) do
  assert_match('Sorry, no results have been found.', page.body, 'Expected an error message saying no results found, however this wasn\'t present')
end
