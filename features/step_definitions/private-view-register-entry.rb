When(/^I view the private register$/) do
  #The URL is accessed directly with generated TN
  puts "#{$PRIVATE_PROPERTY_FRONTEND_DOMAIN}/property/#{$regData['title_number']}"
  visit("#{$PRIVATE_PROPERTY_FRONTEND_DOMAIN}/property/#{$regData['title_number']}")
end

#public detail checks located in citizen-view-register

Then(/^Tenure is displayed$/) do
  assert_selector(".//*[@id='tenure']", text: /#{$regData['property']['tenure']}/)
end

Then(/^Class is displayed$/) do
  assert_selector(".//*[@id='class-of-title']", text: /#{$regData['property']['class_of_title']}/)
end

Then(/^proprietors are displayed$/) do
  assert_selector(".//*[@class='proprietor']/ul/li[1]", text: /#{$regData['proprietors'][0]['first_name']} #{$regData['proprietors'][0]['last_name']}/)
  if $regData['proprietors'][1]['last_name'] != "" then
    assert_selector(".//*[@class='proprietor']/ul/li[2]", text: /#{$regData['proprietors'][1]['first_name']} #{$regData['proprietors'][1]['last_name']}/)
  end
end
