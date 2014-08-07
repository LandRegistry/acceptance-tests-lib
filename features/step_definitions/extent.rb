require 'chunky_png'

Given(/^I check the title plan$/) do
  sleep(2)
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

  $polygon_diff = []

  images.first.height.times do |y|
    images.first.row(y).each_with_index do |pixel, x|
      $polygon_diff << [x,y] unless pixel == images.last[x,y]
    end
  end

  pixels_changed = ($polygon_diff.length.to_f / images.first.pixels.length) * 100

  puts "pixels (total):     #{images.first.pixels.length}"
  puts "pixels changed:     #{$polygon_diff.length}"
  puts "pixels changed (%): #{($polygon_diff.length.to_f / images.first.pixels.length) * 100}%"

  x, y = $polygon_diff.map{ |xy| xy[0] }, $polygon_diff.map{ |xy| xy[1] }

  if (pixels_changed > 0) then
    images.last.rect(x.min, y.min, x.max, y.max, ChunkyPNG::Color.rgb(0,0,0))
  end

  images.last.save("diff2-#{Time.new.to_i}.png")

  assert_operator pixels_changed, :>, 0, 'There is no difference on the map when the polygon is removed'

end

Then(/^the whole polygon is in view$/) do


  x, y = $polygon_diff.map{ |xy| xy[0] }, $polygon_diff.map{ |xy| xy[1] }

  image = ChunkyPNG::Image.from_file($polygon_file1)

  assert_not_equal x.min, 0, 'The Polygon occurpys more than the screen'
  assert_not_equal y.min, 0, 'The Polygon occurpys more than the screen'
  assert_not_equal x.max, image.width - 1, 'The Polygon occurpys more than the screen'
  assert_not_equal y.max, image.height - 1, 'The Polygon occurpys more than the screen'

end

Then(/^the polygon matches that of the title$/) do

end

Then(/^the polygon is edged in red$/) do
  #This gets the form elememt that specifies
  edge_colour = find(".//*[local-name() = 'path']")['stroke']
  if edge_colour !='red' then
    raise "The edging colour shows as " + edge_colour + " when it should be red"
  end

  x, y = $polygon_diff.map{ |xy| xy[0] }, $polygon_diff.map{ |xy| xy[1] }

  image = ChunkyPNG::Image.from_file($polygon_file1)

  poly_colour = []

  found_red = false

  for i in x.min..x.max - 1
    i_x = i
    i_y = y.min + 3
    pixel_colour = {}
    r = ChunkyPNG::Color.r(image[i_x,i_y])
    g = ChunkyPNG::Color.g(image[i_x,i_y])
    b = ChunkyPNG::Color.b(image[i_x,i_y])

    if ((r > 245) && (g < 120) && (b < 120)) then
      found_red = true
    end
  end

  assert_equal found_red, true, 'Expected to find Red on the edge, none found'

end

Then(/^the map can't be zoomed$/) do
  #assert_match(/zoomControl:false/, page.body, 'Expected to find zoomControl:false to show that zoom is not possible')
end

Then(/^the map can't be moved$/) do

end

Then(/^the Polygon is laid over a map$/) do

end
