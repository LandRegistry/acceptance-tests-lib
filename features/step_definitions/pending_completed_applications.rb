Given(/^pending applications exist$/) do

  $pending_cases = []

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $pending_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  $pending_cases[0]['regdata'] = $regData
  $pending_cases[0]['marriage_data'] = $marriage_data

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $pending_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  $pending_cases[1]['regdata'] = $regData
  $pending_cases[1]['marriage_data'] = $marriage_data
  puts $pending_cases[1]

end

Given(/^completed applications exist$/) do

  $completed_cases = []

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $completed_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  $completed_cases[0]['regdata'] = $regData
  $completed_cases[0]['marriage_data'] = $marriage_data

  complete_case($completed_cases[0]['case_id'])

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $completed_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  $completed_cases[1]['regdata'] = $regData
  $completed_cases[1]['marriage_data'] = $marriage_data
  complete_case($completed_cases[1]['case_id'])
  puts $completed_cases[1]

end

When(/^I elect to view requests$/) do
    click_link('View pending and historical changes to this title')
end

Then(/^a separate list of pending requests followed by completed requests are shown in order of receipt by date & time$/) do
  assert_match('Pending changes', page.body, 'Expected to find Pending changes text displayed on the screen')
  assert_match('Previous changes', page.body, 'Expected to find Previous changes text displayed on the screen')
end


Then(/^each request shows the details of the change$/) do
  #$pending_cases
#  {"application_type"=>"change-name-marriage",
#    "title_number"=>"TEST474880244",
#    "submitted_by"=>"Xavier Berry",
#    "request_details"=>{"action"=>"change-name-marriage",
#       "data"=>"{\"proprietor_full_name\":\"Xavier Berry\",
#       \"proprietor_new_full_name\":\"Helen Wall\",
#       \"partner_name\":\"Yvana Foster\",
#       \"marriage_date\":1406592000,
#       \"marriage_place\":\"Needham Market\",
#       \"marriage_country\":\"GB\",
#       \"marriage_certificate_number\":4432695279}",
#       "context"=>{"session-id"=>"123456",
#          "transaction-id"=>"ABCDEFG"}}, "case_id"=>"33"}
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

When(/^I amend the url to directly go to the pending screen$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^an error message is displayed$/) do
  pending # express the regexp above with the code you wish you had
end
