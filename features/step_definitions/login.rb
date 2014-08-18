Given(/^I have private citizen login credentials$/) do
  $userdetails = Hash.new()
  $userdetails['email'] = 'citizen@example.org'
  $userdetails['password'] = 'dummypassword'
end

Given(/^I have caseworker login credentials$/) do
  $userdetails = Hash.new()
  $userdetails['email'] = 'caseworker@example.org'
  $userdetails['password'] = 'dummypassword'
end

Given(/^I am logged in$/) do
  step "I login with correct credentials"
end

When(/^I login with correct credentials$/) do
  fill_in('email', :with => $userdetails['email'])
  fill_in('password', :with => $userdetails['password'])
  click_button('Login')
end

When(/^I login with incorrect username$/) do
  fill_in('email', :with => 'incorrect')
  fill_in('password', :with => $userdetails['password'])
  click_button('Login')
end

Then(/^I fail to login $/) do
  if (!page.body.include? 'Specified user does not exist') then
    raise "Expected error message informing the user was unsuccessful in logging in"
  end
end

When(/^I login with incorrect password$/) do
  fill_in('email', :with => $userdetails['email'])
  fill_in('password', :with => 'incorrect')
  click_button('Login')
end

Then(/^I fail to login \(incorrect username\)$/) do
  if (!page.body.include? 'Specified user does not exist') then
    raise "Expected error message informing the user was unsuccessful in logging in"
  end
end

Then(/^I fail to login \(incorrect password\)$/) do
  if (!page.body.include? 'Invalid password') then
    raise "Expected error message informing the user was unsuccessful in logging in"
  end
end

Given(/^I am still authenticated$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/logout")
  step "I have private citizen login credentials"
  visit("#{$SERVICE_FRONTEND_DOMAIN}/login")
  step "I login with correct credentials"
end

Given(/^I am not already logged in as a private citizen$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/logout")
end

When(/^I logout as a private citizen$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/logout")
end

Then(/^I am prompted to login as a private citizen$/) do
  assert_match(/Please log in to access this page/i, page.body, 'Expected private citizen login page.')
end

When(/^I logout as a caseworker$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}/logout")
end

Then(/^I am prompted to login as a caseworker$/) do
  assert_match(/Please log in to access this page/i, page.body, 'Expected caseworker login page.')
end

Given(/^I am not already logged in as a caseworker$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}/logout")
end

Given(/^I am still authenticated as a caseworker$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}/logout")
  step "I have caseworker login credentials"
  visit("#{$CASEWORK_FRONTEND_DOMAIN}/login")
  step "I login with correct credentials"
end
