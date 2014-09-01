require "net/http"

Given(/^I have registered (.*) property data$/) do |tenure|
  $regData = Hash.new()
  $regData['title_number'] = titleNumber()
  $regData['proprietors'] = Array.new()
  $regData['proprietors'][0] = Hash.new()
  $regData['proprietors'][0]['full_name'] = fullName()
  $regData['proprietors'][1] = Hash.new()
  $regData['proprietors'][1]['full_name'] = fullName()
  $regData['property'] = Hash.new()
  $regData['property']['address'] = Hash.new()
  $regData['property']['address']['address_line_1'] = houseNumber()
  $regData['property']['address']['address_line_2'] = roadName()
  $regData['property']['address']['address_line_3'] = roadName()
  $regData['property']['address']['address_line_4'] = roadName()
  $regData['property']['address']['city'] = townName()
  $regData['property']['address']['postcode'] = postcode()

  $regData['property']['tenure'] = tenure

  $regData['property']['address']['country'] = 'GB'

  $regData['property']['class_of_title'] = 'absolute'
  $regData['payment'] = Hash.new()
  $regData['payment']['price_paid'] = pricePaid()
  $regData['payment']['titles'] = Array.new()
  $regData['payment']['titles'][0] = $regData['title_number']
  $regData['extent'] = genenerate_title_extent(1)

  if tenure =='Leasehold' then
    #build up the leasehold structure
    $regData['leases'] = Array.new()
    $regData['leases'][0] = Hash.new()
    $regData['leases'][0]['lease_term'] = rand(7..999)
    $regData['leases'][0]['lease_easements'] = true
    $regData['leases'][0]['lease_date'] = Date.today.prev_day.strftime("%Y-%m-%d")
    $regData['leases'][0]['title_registered'] = true
    $regData['leases'][0]['lessee_name'] = firstName() + ' ' + surname() +'s, '+firstName() + ' ' + surname() + 's'
    $regData['leases'][0]['alienation_clause'] = true
    $regData['leases'][0]['lease_from'] = Date.today.prev_day.strftime("%Y-%m-%d")
    $regData['leases'][0]['lessor_name'] = firstName() + ' ' + surname() +', '+firstName() + ' ' + surname()
  end

  $regData['charges'] = Array.new()
  $regData['charges'][0] = Hash.new()
  $regData['charges'][0]['charge_date'] = '2014-08-11'
  $regData['charges'][0]['chargee_address'] = '12 Test Street, London, SE1 33S'
  $regData['charges'][0]['chargee_name'] = 'Test Bank'
  $regData['charges'][0]['chargee_registration_number'] = '1234567'
  $regData['easements'] = Array.new()
  puts 'Title number' + $regData['title_number']

end

Given(/^I submit the registered property data$/) do

  uri = URI.parse($MINT_API_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/titles/' + $regData['title_number'],  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = $regData.to_json
  response = http.request(request)

  if (response.code != '201') then
    raise "Failed creating register: " + response.body
  end

  wait_for_register_to_be_created($regData['title_number'])

end


Given(/^I have a registered property$/) do
  step "I have registered Freehold property data"
  step "I submit the registered property data"
end

Given(/^I have a registered (.*) property$/) do |tenure|
  step "I have registered " + tenure +" property data"
  step "I submit the registered property data"
end

Given(/^I have a registered property with multiple polygons$/) do
  step "I have registered Freehold property data"
  $regData['extent'] = genenerate_title_extent(2)
  step "I submit the registered property data"
end


Given(/^I have a registered property with an easement$/) do
  step "I have registered Freehold property data"
  $regData['extent'] = genenerate_title_extent(1)

  $regData['easements'][0] = {}
  $regData['easements'][0]['easement_geometry'] = generate_easement_for_title_extent($regData['extent'])
  $regData['easements'][0]['easement_description'] = 'Easement Description'

  step "I submit the registered property data"
end

Given(/^I have a registered property with donut polygons$/) do
  step "I have registered Freehold property data"
  $regData['extent'] = genenerate_title_extent_donut(1)
  step "I submit the registered property data"
end

Given(/^I am searching for that property$/) do
  puts "#{$PROPERTY_FRONTEND_DOMAIN}/search"
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/search")
end

Given(/^I am a citizen$/) do
  # Nothing can be done here, maybe click a logout button if it exists?
  step "I am not already logged in as a private citizen"
end

When(/^I enter an incorrect Title Number \(non\-matching\)$/) do
  fill_in('search', :with => '123456')
end

When(/^I search$/) do
  click_button('Search')
end

Then(/^no results are found$/) do
  if (!page.body.include? 'No results found') then
    raise "Expected an error message saying no results found, however this wasn't present"
  end
end

When(/^I enter the exact Title Number$/) do
  fill_in('search', :with => $regData['title_number'])
end

Then(/^the citizen register is displayed$/) do
  puts $regData['title_number']
  # This step isn't ideal. I need something on the page to show it is the citizen registration.
  if (page.body.include? $regData['proprietors'][0]['full_name']) then
    raise "Expected to find no names on this register, this means it isn't the public register."
  end
end

Given(/^at least two registers with the same Title Number beginning exists$/) do
  # Currently I am unsure how to do this as the developer aren't sure how it will happen.
  $results = Array[]
  step "I have a registered freehold property"
  $results[0] = $regData
  step "I have a registered freehold property"
  $results[1] = $regData
  # For now I am calling this step twice to create 2 registers, I will then search for TEST*
end

When(/^I enter a Title Number with the same prefix$/) do
  fill_in('search', :with => 'TEST')
end

Then(/^multiple results are displayed$/) do
  #Add the correct xpath here for the results
  if (page.all(".//*[@id='ordered']/li").count < 2) then
    raise "Less than 2 result returned"
  end
end

Then(/^results show address details$/) do
  for i in 0..$results.count
    assert_match(/#{$results[i]['property']['address']['house_number']}/i, page.body, 'Expected to find house_number')
    assert_match(/#{$results[i]['property']['address']['road'].gsub(')', '\)').gsub('(', '\(')}/i, page.body, 'Expected to find road')
    assert_match(/#{$results[i]['property']['address']['town']}/i, page.body, 'Expected to find town')
    assert_match(/#{$results[i]['property']['address']['postcode']}/i, page.body, 'Expected to find postcode')
  end
end

Then(/^results show Title Number$/) do
  for i in 0..$results.count
    if (page.body.include? $results[i]['title_number']) then
      raise "Expected to find title number #{$results[i]['title_number']}, but not present."
    end
  end
end

When(/^I select a result$/) do
  click_link('Title Number: ' + $regData['title_number'])
end

Given(/^easements within the lease clause (NOT|is) existing$/) do |easement_clause|
  if easement_clause == 'NOT' then
    $regData['leases'][0]['lease_easements'] = false
  else
    $regData['leases'][0]['lease_easements'] = true
  end
end

Given(/^alienation clause (NOT|is) existing$/) do |alienation_clause|
  if alienation_clause == 'NOT' then
    $regData['leases'][0]['alienation_clause'] = false
  else
    $regData['leases'][0]['alienation_clause'] = true
  end
end

Given(/^landlords title registered clause (NOT|is) existing$/) do |landlord_clause|
  if landlord_clause =='NOT' then
    $regData['leases'][0]['title_registered'] = false
  else
    $regData['leases'][0]['title_registered'] = true
  end
end

Given(/^Lessee name is (different|same) as proprietor$/) do |lessee_name_as_proprietor|
  #lessee name is alreday different so only need to make same as necessary
  #only puts the first proprietor name as lessee, varients should be covered in unit test
  if lessee_name_as_proprietor == 'same' then
    $regData['leases'][0]['lessee_name'] = $regData['proprietors'][0]['first_name'] + ' ' + $regData['proprietors'][0]['last_name']
  end
end
