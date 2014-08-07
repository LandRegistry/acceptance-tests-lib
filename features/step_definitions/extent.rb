require 'chunky_png'

Given(/^I check the title plan$/) do
  $polygon_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  $polygon_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  save_screenshot($polygon_file1, :selector => "#map")

  page.execute_script("document.getElementsByClassName('leaflet-overlay-pane')[0].innerHTML = '';")

  save_screenshot($polygon_file2, :selector => "#map")

  visit page.driver.browser.current_url

end

Then(/^there is at least one polygon$/) do

  images = [
    ChunkyPNG::Image.from_file($polygon_file2),
    ChunkyPNG::Image.from_file($polygon_file1)
  ]

  diff = []

  images.first.height.times do |y|
    images.first.row(y).each_with_index do |pixel, x|
      diff << [x,y] unless pixel == images.last[x,y]
    end
  end

  puts "pixels (total):     #{images.first.pixels.length}"
  puts "pixels changed:     #{diff.length}"
  puts "pixels changed (%): #{(diff.length.to_f / images.first.pixels.length) * 100}%"

  x, y = diff.map{ |xy| xy[0] }, diff.map{ |xy| xy[1] }

  images.last.rect(x.min, y.min, x.max, y.max, ChunkyPNG::Color.rgb(0,0,0))
  images.last.save("diff2-#{Time.new.to_i}.png")

end

Then(/^the whole polygon is in view$/) do

end

Then(/^the polygon matches that of the title$/) do

end

Then(/^the polygon is edged in red$/) do
  #This gets the form elememt that specifies
  edge_colour = find(".//*[local-name() = 'path']")['stroke']
  if edge_colour !='red' then
    raise "The edging colour shows as " + edge_colour + " when it should be red"
  end
end

Then(/^the map can't be zoomed$/) do
  #assert_match(/zoomControl:false/, page.body, 'Expected to find zoomControl:false to show that zoom is not possible')
end

Then(/^the map can't be moved$/) do

end

Then(/^the Polygon is laid over a map$/) do

end
