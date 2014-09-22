Given(/^a registered title with characteristics$/) do |table|
  $regData = generic_register_data(table)
end

Given(/^I am the proprietor of a registered title with characteristics$/) do |table|
  step "a registered title with characteristics exists", table
  link_title_to_email($userdetails['email'], $regData['title_number'], 'CITIZEN')
end

Given(/^a registered title$/) do
  step "a registered title with characteristics", ''
end

Given(/^I am the proprietor of a registered title$/) do
  step "a registered title with characteristics", ''
  link_title_to_email($userdetails['email'], $regData['title_number'], 'CITIZEN')
end

Given(/^a registered property$/) do
  step "a registered title with characteristics exists", ''
end
