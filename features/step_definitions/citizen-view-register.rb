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

Then(/^No lease information is displayed$/) do
  #confirm lease info is not shown when tenure is freehold
  assert_no_selector(".//*[@id='leaseDate']")
  assert_no_selector(".//*[@id='leaseTerm']")
  assert_no_selector(".//*[@id='parties']")
end

Then(/^Date of Lease is displayed$/) do

  lease_date_formatted = Date.parse($regData['leases'][0]['lease_date'])
  lease_date_formatted = lease_date_formatted.strftime("%d %B %Y")
  assert_selector(".//*[@id='leaseDate']", text: lease_date_formatted)
end

Then(/^Lease Term is displayed$/) do
  assert_selector(".//*[@id='leaseTerm']", text: /#{$regData['leases'][0]['lease_term']} years/)
end

Then(/^Lease Term start date is displayed$/) do
  lease_term_start_date_formatted = Date.parse($regData['leases'][0]['lease_from'])
  lease_term_start_date_formatted = lease_term_start_date_formatted.strftime("%d %B %Y")
  assert_selector(".//*[@id='leaseTerm']", text: /from #{lease_term_start_date_formatted}/)
end

Then(/^Lessor name is displayed$/) do
  assert_selector(".//*[@id='parties']", text: /1. #{$regData['leases'][0]['lessor_name']}/)
end

Then(/^Lessee name (NOT|is) displayed$/) do |lessee_to_be_displayed|
  if lessee_to_be_displayed =='is' then
    assert_selector(".//*[@id='parties']", text: /2. #{$regData['leases'][0]['lessee_name']}/)
  else
    assert_no_selector(".//*[@id='parties']", text: /2. #{$regData['leases'][0]['lessee_name']}/)
  end
end

Then(/^easements within the lease clause (NOT|is) displayed$/) do |easement_clause_displayed|
  if easement_clause_displayed == 'NOT' then
    assert_no_selector(".//*[@id='easementClause']")
  else
    assert_selector(".//*[@id='easementClause']")
  end
end

Then(/^alienation clause (NOT|is) displayed$/) do |alienation_clause_displayed|
  if alienation_clause_displayed == 'NOT' then
    assert_no_selector(".//*[@id='alienationClause']")
  else
    assert_selector(".//*[@id='alienationClause']")
  end
end

Then(/^landlords title registered clause (NOT|is) displayed$/) do |landlords_clause_displayed|
  if landlords_clause_displayed == 'NOT' then
    assert_no_selector(".//*[@id='titleRegisteredClause']")
  else
    assert_selector(".//*[@id='titleRegisteredClause']")
  end
end
