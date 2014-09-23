Given(/^pending applications exist$/) do

  $pending_cases = []

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $pending_cases << create_change_of_name_marriage_request($regData, $marriage_data)

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $pending_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  puts $pending_cases

end

Given(/^completed applications exist$/) do

  $completed_cases = []

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $completed_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  complete_case($completed_cases[0]['case_id'])

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $completed_cases << create_change_of_name_marriage_request($regData, $marriage_data)
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

  Then(/^the correct data is displayed$/) do

  #Loop through the data held on the pending applications table i.e. the cases table


    for i in 0 ..$pending_cases.count - 1



  #assert_match('SUBMITTED ON', page.body, 'Expected to find SUBMITTED ON text displayed on the screen')


    puts "row = "
    puts $pending_cases[i]["title_number"]
    puts $pending_cases[i]["submitted_by"]
    puts $pending_cases[i]["proprietor_full_name"]
    puts $pending_cases[i]["proprietor_new_full_name"]
    puts $pending_cases[i]["marriage_date"]
    puts $pending_cases[i]["marriage_certificate_number"]
    puts $pending_cases[i]["marriage_place"]
    puts $pending_cases[i]["marriage_country"]




    end
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
