Given(/^pending applications exist$/) do

  $pending_cases = []

  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $pending_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  $pending_cases[0]['regdata'] = $regData
  $pending_cases[0]['marriage_data'] = $marriage_data

  $regData['proprietors'][0]['full_name'] = $marriage_data['proprietor_new_full_name']
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

  $regData['proprietors'][0]['full_name'] = $marriage_data['proprietor_new_full_name']
  $marriage_data = create_marriage_data('GB', $regData['proprietors'][0]['full_name'])
  $completed_cases << create_change_of_name_marriage_request($regData, $marriage_data)
  $completed_cases[1]['regdata'] = $regData
  $completed_cases[1]['marriage_data'] = $marriage_data
  complete_case($completed_cases[1]['case_id'])
  puts $completed_cases[1]

  sleep(1)
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

    if (!$pending_cases.nil?)

    for i in 0 ..$pending_cases.count - 1

    puts "row = "
    puts $pending_cases[i]["title_number"]
    puts $pending_cases[i]["submitted_by"]
    puts $pending_cases[i]["marriage_data"]["proprietor_full_name"]
    puts $pending_cases[i]["marriage_data"]["proprietor_new_full_name"]
    puts $pending_cases[i]["marriage_data"]["marriage_date"]
    puts $pending_cases[i]["marriage_data"]["marriage_certificate_number"]
    puts $pending_cases[i]["marriage_data"]["marriage_place"]
    puts $pending_cases[i]["marriage_data"]["marriage_country"]

    assert_match($pending_cases[i]["title_number"], page.body, 'Expected to find '+ $pending_cases[i]["title_number"] +' displayed on the screen')
    assert_match($pending_cases[i]["submitted_by"], page.body, 'Expected to find '+ $pending_cases[i]["submitted_by"] +' displayed on the screen')
    assert_match($pending_cases[i]["marriage_data"]["proprietor_full_name"], page.body, 'Expected to find '+ $pending_cases[i]["marriage_data"]["proprietor_full_name"] +' displayed on the screen')
    assert_match($pending_cases[i]["marriage_data"]["proprietor_new_full_name"], page.body, 'Expected to find '+ $pending_cases[i]["marriage_data"]["proprietor_new_full_name"] +' displayed on the screen')
    assert_match($pending_cases[i]["marriage_data"]['marriage_date'].to_s, page.body, 'Expected to find ' + $pending_cases[i]["marriage_data"]["marriage_date"].to_s + ' displayed on the screen')
    assert_match($pending_cases[i]["marriage_data"]["marriage_certificate_number"].to_s, page.body, 'Expected to find '+ ($pending_cases[i]["marriage_data"]["marriage_certificate_number"].to_s) +' displayed on the screen')
    assert_match($pending_cases[i]["marriage_data"]["marriage_place"], page.body, 'Expected to find '+ $pending_cases[i]["marriage_data"]["marriage_place"] +' displayed on the screen')
    assert_match($pending_cases[i]["marriage_data"]["marriage_country"], page.body, 'Expected to find '+ $pending_cases[i]["marriage_data"]["marriage_country"] +' displayed on the screen')
    end
  end  # of $pending_cases loop


  if (!$completed_cases.nil?)

    puts $completed_cases

    for i in 0 ..$completed_cases.count - 1

      assert_match($completed_cases[i]["title_number"], page.body, 'Expected to find '+ $completed_cases[i]["title_number"] +' displayed on the screen')
      assert_match($completed_cases[i]["submitted_by"], page.body, 'Expected to find '+ $completed_cases[i]["submitted_by"] +' displayed on the screen')

    end  # of $completed_cases loop

  end
  $pending_cases = nil # Lets Tidy up, so that another scenario doesn't resuse this data
  $completed_cases = nil # Lets Tidy up, so that another scenario doesn't resuse this data


  end


Then(/^a list of pending requests are shown in order of receipt by date & time$/) do
  i = 0

  puts $pending_cases.count
  page.all(".//ol[@class='register-changes-pending']/li").each do |el|
    name = el.find('.//div/ul/li[2]').text
    assert_match($pending_cases[i]["marriage_data"]["proprietor_new_full_name"], 'Previous name: ' + name, 'Expected to find '+ $pending_cases[i]["marriage_data"]["proprietor_new_full_name"] +' displayed on the screen')
    i += 1
  end
end

Then(/^a separate list of completed requests are shown in order of receipt by date & time$/) do
  i = 0
  page.all(".//ol[@class='register-changes-previous']/li/div/p").each do |el|
    assert_match($completed_cases[i]["marriage_data"]["proprietor_full_name"], 'Submitted by: ' + el.text, 'Expected to find '+ $completed_cases[i]["marriage_data"]["proprietor_full_name"] +'')
    i += 1
  end
end

Then(/^a view requests option is not displayed$/) do
    assert_equal has_link?('View pending and historical changes to this title'), false, 'Expected View pending and historical changes to this title link to not be on the page'
end

Then(/^an error message re unauthorised is displayed$/) do
  assert_match('Unauthorised', page.body, 'Expected to find Unauthorised text displayed on the screen')
end

Then(/^the no pending nor completed requests screen are displayed$/) do
  assert_match('No pending changes', page.body, 'Expected to find No pending changes text displayed on the screen')
  assert_match('No previous changes', page.body, 'Expected to find No previous changes text displayed on the screen')
end
