When(/^I view the caseworker worklist$/) do
  click_link('Casework list')
end

When(/^I view the check worklist$/) do
  click_link('Check list')
end

Then(/^Date Submitted is displayed in the worklist$/) do
  puts "step needs to be implemented"
end

Then(/^Application Type shows as change of name in the worklist$/) do
  titleList = page.all(:xpath, ".//tr[td//text()[contains(.,'" + $regData['title_number'] + "')]]")
  assert_equal(titleList.length, 1, 'There are zero or more than one entries for title' + $regData['title_number'])
  assert_match('change of name', titleList[0].text, 'Expected change of name: ' + $regData['title_number'])
end

Then(/^Title Number is displayed in the worklist$/) do
  titleList = page.all(:xpath, ".//tr[td//text()[contains(.,'" + $regData['title_number'] + "')]]")
  assert_equal(titleList.length, 1, 'There are zero or more than one entries for title' + $regData['title_number'])
  assert_match($regData['title_number'], titleList[0].text, 'Expected correct title number: ' + $regData['title_number'])
end

Then(/^queue is ascending by order of submission$/) do
  puts "step needs to be implemented"
end
