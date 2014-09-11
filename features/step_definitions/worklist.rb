When(/^I view the caseworker worklist$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}")
  step "I login with correct credentials"
  click_link('Casework list')
end

When(/^I view the check worklist$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}")
  step "I login with correct credentials"
  click_link('Check list')
end

Then(/^Date Submitted is displayed in the worklist$/) do
  titleList = page.all(:xpath, ".//tr[td//text()[contains(.,'" + $regData['title_number'] + "')]]")
  assert_equal(titleList.length, 1, 'There are zero or more than one entries for title' + $regData['title_number'])
  assert_match($data['dateSubmitted'], titleList[0].text, 'Expected the date ' + $data['dateSubmitted'] + ' in ' + titleList[0].text)
end

Then(/^Application Type shows as change of name in the worklist$/) do
  titleList = page.all(:xpath, ".//tr[td//text()[contains(.,'" + $regData['title_number'] + "')]]")
  assert_equal(titleList.length, 1, 'There are zero or more than one entries for title' + $regData['title_number'])
  assert_match('change of name', titleList[0].text, 'Expected change of name text in ' + titleList[0].text)
end

Then(/^Title Number is displayed in the worklist$/) do
  titleList = page.all(:xpath, ".//tr[td//text()[contains(.,'" + $regData['title_number'] + "')]]")
  assert_equal(titleList.length, 1, 'There are zero or more than one entries for title' + $regData['title_number'])
  assert_match($regData['title_number'], titleList[0].text, 'Expected the title number' + $regData['title_number'] + ' in ' + titleList[0].text)
end

Then(/^queue is ascending by order of submission$/) do
  puts "step needs to be implemented"
end
