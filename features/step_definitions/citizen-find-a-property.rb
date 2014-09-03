Given(/^I am searching for that property$/) do
  puts "#{$PROPERTY_FRONTEND_DOMAIN}/search"
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/search")
end

Given(/^I am a citizen$/) do
  # Nothing can be done here, maybe click a logout button if it exists?
  step "I am not already logged in as a private citizen"
end

When(/^I enter an incorrect Title Number \(non\-matching\)$/) do
  fill_in('search', :with => '123456')
end

When(/^I search$/) do
  click_button('Search')
end

Then(/^no results are found$/) do
  if (!page.body.include? 'No results found') then
    raise "Expected an error message saying no results found, however this wasn't present"
  end
end

When(/^I enter the exact Title Number$/) do
  fill_in('search', :with => $regData['title_number'])
end

Then(/^the citizen register is displayed$/) do
  puts $regData['title_number']
  # This step isn't ideal. I need something on the page to show it is the citizen registration.
  if (page.body.include? $regData['proprietors'][0]['full_name']) then
    raise "Expected to find no names on this register, this means it isn't the public register."
  end
end

Given(/^at least two registers with the same Title Number beginning exists$/) do
  # Currently I am unsure how to do this as the developer aren't sure how it will happen.
  $results = Array[]
  step "I have a registered Freehold property"
  $results[0] = $regData
  step "I have a registered Freehold property"
  $results[1] = $regData
  # For now I am calling this step twice to create 2 registers, I will then search for TEST*
end

When(/^I enter a Title Number with the same prefix$/) do
  fill_in('search', :with => 'TEST')
end

Then(/^multiple results are displayed$/) do
  #Add the correct xpath here for the results
  if (page.all(".//*[@id='ordered']/li").count < 2) then
    raise "Less than 2 result returned"
  end
end

Then(/^results show address details$/) do
  for i in 0..$results.count
    assert_match(/#{$results[i]['property']['address']['house_number']}/i, page.body, 'Expected to find house_number')
    assert_match(/#{$results[i]['property']['address']['road'].gsub(')', '\)').gsub('(', '\(')}/i, page.body, 'Expected to find road')
    assert_match(/#{$results[i]['property']['address']['town']}/i, page.body, 'Expected to find town')
    assert_match(/#{$results[i]['property']['address']['postcode']}/i, page.body, 'Expected to find postcode')
  end
end

Then(/^results show Title Number$/) do
  for i in 0..$results.count
    if (page.body.include? $results[i]['title_number']) then
      raise "Expected to find title number #{$results[i]['title_number']}, but not present."
    end
  end
end

When(/^I select a result$/) do
  click_link('Title Number: ' + $regData['title_number'])
end
