require 'chunky_png'

Given(/^I check the title plan$/) do
  $polygon_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  $polygon_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  save_screenshot($polygon_file1, :selector => "#map")

  page.execute_script("document.getElementsByClassName('leaflet-overlay-pane')[0].innerHTML = '';")

  save_screenshot($polygon_file2, :selector => "#map")

  page.driver.browser.refresh

end

Then(/^there is at least one polygon$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the whole polygon is in view$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the polygon matches that of the title$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the polygon is edged in red$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the map can't be zoomed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the map can't be moved$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the Polygon is laid over a map$/) do
  pending # express the regexp above with the code you wish you had
end
