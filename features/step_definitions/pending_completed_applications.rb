Given(/^pending applications exist$/) do
  $pending_cases = []

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $pending_cases << create_change_of_name_marriage_request($regData, $marriage_data)

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $pending_cases << create_change_of_name_marriage_request($regData, $marriage_data)

end

Given(/^completed applications exist$/) do

  $completed_cases = []

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $completed_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  complete_case($completed_cases[0]['case_id'])

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $completed_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  complete_case($completed_cases[1]['case_id'])

end

When(/^I elect to view requests$/) do
  #click_link
end

Then(/^a separate list of pending requests followed by completed requests are shown in order of receipt by date & time$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^each request shows the details of the change$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the correct data is displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^a list of pending requests are shown in order of receipt by date & time$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^a separate list of completed requests are shown in order of receipt by date & time$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^a view requests option is not displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I am not the proprietor of a registered title$/) do
    step "a registered title with characteristics", ''
    #do not link title to email i.e. this title will not be owned by this propritor
end

Given(/^a view requests option is not displayed$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I amend the url to directly go to the pending screen$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^an error message is displayed$/) do
  pending # express the regexp above with the code you wish you had
end
