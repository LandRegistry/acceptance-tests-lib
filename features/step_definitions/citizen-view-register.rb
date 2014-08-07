Then(/^the address of property is displayed$/) do
  assert_match(/#{$regData['property']['address']['house_number']}/i, page.body, 'Expected to find house_number')
  assert_match(/#{$regData['property']['address']['road'].gsub(')', '\)').gsub('(', '\(')}/i, page.body, 'Expected to find road')
  assert_match(/#{$regData['property']['address']['town']}/i, page.body, 'Expected to find town')
  assert_match(/#{$regData['property']['address']['postcode']}/i, page.body, 'Expected to find postcode')
end

Then(/^Title Number is displayed$/) do
  assert_selector(".//*[@id='content']/div/h1/span", text: /#{$regData['title_number']}/)
end

Then(/^Price Paid is displayed$/) do
  assert_selector(".//*[@id='price-paid']", text: /#{$regData['payment']['price_paid'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}/)
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

Then(/^the Title Extent is displayed$/) do
  #finds the main map object
  #map = find(".//*[@id='map']")
  #puts map.native.inner_html
  #sleep 5
  #finds the
  #map_results = find(".//*[@class='leaflet-overlay-pane']")
  #puts map_results
  #page.save_screenshot "sshot-#{Time.new.to_i}.png", :full=>true
  #puts "separation"
  #locates the actual map script to check geojson etc
  #mapjs = find(".//*[@id='map']/script").value
  #puts mapjs
end
