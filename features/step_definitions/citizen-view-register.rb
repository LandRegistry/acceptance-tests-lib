Then(/^the address of property is displayed$/) do
  assert_match(/#{$regData['property']['address']['address_line_1']}/i, page.body, 'Expected to find address line 1')
  assert_match(/#{$regData['property']['address']['address_line_2'].gsub(')', '\)').gsub('(', '\(')}/i, page.body, 'Expected to find address line 2')
  assert_match(/#{$regData['property']['address']['city']}/i, page.body, 'Expected to find city')
  assert_match(/#{$regData['property']['address']['postcode']}/i, page.body, 'Expected to find postcode')
end

Then(/^Title Number is displayed$/) do
  assert_match(/#{$regData['title_number']}/i, page.body, 'Expected to see title number')
  #assert_selector(".//*[@id='content']/div/h1/span", text: /#{$regData['title_number']}/)
end

Then(/^Price Paid is displayed$/) do
  assert_match(/#{$regData['payment']['price_paid'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}/i, page.body, 'Expected to see price paid')
  #assert_selector(".//*[@id='price-paid']", text: /#{$regData['payment']['price_paid'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}/)
end

When(/^I try to view a register that does not exist$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/property/XXXXXXXXX")
end

Then(/^an error will be displayed$/) do
  if (!page.body.include? 'Page not found') then
    raise "Expected not to find the page"
  end
end

When(/^I view the register$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/property/#{$regData['title_number']}")
end
