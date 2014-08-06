
Given(/^I view leaflet$/) do
  visit('http://leafletjs.com')
end

Then(/^I save a picture$/) do
  save_screenshot("filea-#{Time.new.to_i}.png", :selector => "#map")
end
