Given(/^a registered title with characteristics$/) do |table|
  #$regData = generic_register_data(table)
  create_base_register(table)
end

Given(/^a registered title$/) do
  step "a registered title with characteristics", ''
end

Given(/^I am the proprietor of a registered title$/) do
  step "a registered title with characteristics", ''
  link_title_to_email($userdetails['email'], $regData['title_number'], 'CITIZEN')
end

Then(/^the register of title is updated with the new name$/) do
  wait_for_register_to_update_full_name($regData['title_number'], $marriage_data['proprietor_new_full_name'])

  title_number = $regData['title_number']

  found_count = 0
  count = 0
  while (found_count != 1 && count < 25) do
    puts 'waiting for new version of title to be created'
    sleep(0.2)
    response = get_register_details(title_number)
    puts 'name on title: '  + JSON.parse(response)['proprietors'][0]['full_name']
    puts 'expected name on title: ' + $marriage_data['proprietor_new_full_name']
    if (!response.nil?)
      if (JSON.parse(response)['proprietors'][0]['full_name']==$marriage_data['proprietor_new_full_name'])
        found_count = 1
        puts 'Title updated'
      end
    end
    count = count + 1
  end
  if (found_count != 1) then
    raise "Title not updated " + title_number
  end
end
