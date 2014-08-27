Then(/^the address of property is displayed$/) do
  assert_match(/#{$regData['property']['address']['house_number']}/i, page.body, 'Expected to find house_number')
  assert_match(/#{$regData['property']['address']['road'].gsub(')', '\)').gsub('(', '\(')}/i, page.body, 'Expected to find road')
  assert_match(/#{$regData['property']['address']['town']}/i, page.body, 'Expected to find town')
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

Then(/^No lease information is displayed$/) do
  #confirm lease info is not shown when tenure is freehold
  pending # express the regexp above with the code you wish you had
end

Then(/^Date of Lease is displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^Lease Term is displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^Lease Term start date is displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^Lessor name is displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^Lessee name is displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^easements within the lease clause NOT displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^alienation clause NOT displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^landlords title registered clause NOT displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^Lessor name NOT displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^easements within the lease clause is displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^alienation clause is displayed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^landlords title registered clause is displayed$/) do
  pending # express the regexp above with the code you wish you had
end
