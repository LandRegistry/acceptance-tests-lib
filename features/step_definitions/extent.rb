require 'chunky_png'

Given(/^I check the title plan$/) do
  sleep(2)
  $polygon_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  $polygon_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  save_screenshot($polygon_file1, :selector => "#map")

  page.execute_script("document.getElementsByClassName('leaflet-overlay-pane')[0].innerHTML = '';")

  save_screenshot($polygon_file2, :selector => "#map")

  visit page.driver.browser.current_url

  $map_details = get_polygon_details($polygon_file1, $polygon_file2)

  puts $map_details

end

Then(/^there is (\d+) polygon(s|)$/) do |expected_polygon_count, wording|

  assert_equal expected_polygon_count.to_i, $map_details['polygon_count'], 'Expected different amount of polygons'

end

Then(/^the whole polygon area is in view$/) do

  $map_details['polygons'].each do |polygon|

    assert_not_equal polygon['x.min'], 0, 'The Polygon occurpys more than the screen'
    assert_not_equal polygon['y.min'], 0, 'The Polygon occurpys more than the screen'
    assert_not_equal polygon['x.max'], $map_details['width'] - 1, 'The Polygon occurpys more than the screen'
    assert_not_equal polygon['y.max'], $map_details['height'] - 1, 'The Polygon occurpys more than the screen'

  end

end

Then(/^the polygon(s|) matches that of the title$/) do |wording|
  pending
end

Then(/^the polygon(s are| is) edged in red$/) do |wording|

  assert_equal (find(".//*[local-name() = 'path']")['stroke']) , 'red', 'Expected the edging to be red'

  $map_details['polygons'].each do |polygon|

    image = ChunkyPNG::Image.from_file($polygon_file1)

    poly_colour = []

    found_red = false

    for i in polygon['x.min']..polygon['x.max'] - 1
      i_x = i
      i_y = polygon['y.min'] + 3
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

end

Then(/^the map can't be zoomed$/) do
  uri = URI.parse($PROPERTY_FRONTEND_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new('/static/build//javascripts/map.js')
  response = http.request(request)
  puts response.body
end

Then(/^the map can't be moved$/) do
  pending
end

Then(/^the Polygon(s are| is) laid over a map$/) do |wording|
  pending
end
