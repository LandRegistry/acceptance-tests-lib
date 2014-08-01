Given(/^I have login credentials$/) do
  $userdetails = Hash.new()
  $userdetails['email'] = 'citizen@example.org'
  $userdetails['password'] = 'dummypassword'
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
  step "I have login credentials"
  visit("#{$SERVICE_FRONTEND_DOMAIN}/login")
  step "I login with correct credentials"
end

Given(/^I am not already logged in$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/logout")
end
