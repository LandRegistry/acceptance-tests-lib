require 'oily_png'

Given(/^I check the title plan$/) do
  sleep(2)

  # Get names for the 2 files we will produce
  $polygon_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  $polygon_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  # Make the shape more vivid
  page.execute_script("geoJson.setStyle({opacity: 1, weight: 2});")

  # Take a screen show of the map id div tag
  save_screenshot($polygon_file1, :selector => "#map")

  # Remove the geojson layer of the map
  page.execute_script("map.removeLayer(geoJson);")

  # Now take another screenshot without the geojson there
  save_screenshot($polygon_file2, :selector => "#map")

  # readd the layer back in to in sure the map is correct for other tests
  page.execute_script("map.addLayer(geoJson);")

  # Compare the images to get the polygon details
  $map_details = get_polygon_details($polygon_file1, $polygon_file2)

  puts $map_details

end

Then(/^there is (\d+) polygon(s|)$/) do |expected_polygon_count, wording|
  # Compare the polygon count
  assert_equal expected_polygon_count.to_i, $map_details['polygon_count'], 'Expected different amount of polygons'
end

Then(/^the whole polygon area is in view$/) do
  # Check to see if the min/max x and y don't touch the border for each polygon
  $map_details['polygons'].each do |polygon|
    assert_not_equal polygon['x.min'], 0, 'The Polygon occupies more than the screen'
    assert_not_equal polygon['y.min'], 0, 'The Polygon occupies more than the screen'
    assert_not_equal polygon['x.max'], $map_details['width'] - 1, 'The Polygon occupies more than the screen'
    assert_not_equal polygon['y.max'], $map_details['height'] - 1, 'The Polygon occupies more than the screen'
  end
end

Then(/^the polygon(s|) matches that of the title$/) do |wording|
  # Check to see of the coordinates exist on the html source code
  for i in 0..($regData['extent']['geometry']['coordinates'].count) -1
    for j in 0..($regData['extent']['geometry']['coordinates'][i].count) -1
      assert_match($regData['extent']['geometry']['coordinates'][i][j][0].to_s, page.body, 'expected map co-ordinates not present')
      assert_match($regData['extent']['geometry']['coordinates'][i][j][1].to_s, page.body, 'expected map co-ordinates not present')
    end
  end
end

Then(/^the polygon(s are| is) edged in red$/) do |wording|
  # Check the source code of the html for the stroke of red
  assert_equal (find(".//*[local-name() = 'path']")['stroke']) , 'red', 'Expected the edging to be red'

  #And also check the border of the polygon to see if it is red
  $map_details['polygons'].each do |polygon|

    image = ChunkyPNG::Image.from_file($polygon_file1)

    poly_colour = []

    found_red = false
    # loop though one line of the image to see if it is red
    for i in polygon['x.min']..polygon['x.max'] - 1
      i_x = i
      i_y = polygon['y.min'] + 2
      pixel_colour = {}
      r = ChunkyPNG::Color.r(image[i_x,i_y])
      g = ChunkyPNG::Color.g(image[i_x,i_y])
      b = ChunkyPNG::Color.b(image[i_x,i_y])

      # Red has a high r value and low g and b
      if ((r > 245) && (g < 120) && (b < 120)) then
        found_red = true
      end
    end

    # Check to see if red was found
    assert_equal found_red, true, 'Expected to find Red on the edge, none found'

  end

end

Then(/^the map can't be zoomed$/) do
  # Generate some new map names.
  map_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  map_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  # Save the map area as a screenshot
  save_screenshot(map_file1, :selector => "#map")

  # Send plus key to see if the map zooms
  find(".//*[@id='map']").native.send_key('+')
  sleep(1)
  # save a screen with the image after the key press
  save_screenshot(map_file2, :selector => "#map")

  # See if the maps now compare
  maps_match = compare_maps(map_file1, map_file2)

  # If they don't match, then raise a an error
  assert_equal true, maps_match, 'The hash of the Image files does not match, this must mean the images are different'

end

Then(/^the map can't be moved$/) do
  # Generate some new map names.
  map_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  map_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  # Save the map area as a screenshot
  save_screenshot(map_file1, :selector => "#map")

  # Send an arrow key to see if the map zooms
  find(".//*[@id='map']").native.send_key(:arrow_down)
  sleep(1)

  # save a screen with the image after the key press
  save_screenshot(map_file2, :selector => "#map")

  # See if the maps now compare
  maps_match = compare_maps(map_file1, map_file2)

  # If they don't match, then raise a an error
  assert_equal true, maps_match, 'The hash of the Image files does not match, this must mean the images are different'

end

Then(/^the Polygon(s are| is) laid over a map$/) do |wording|

  # Generate some new map names.
  map_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  map_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  # Save the map area as a screenshot
  save_screenshot(map_file1, :selector => "#map")

  # Remove the underlying map layer
  page.execute_script("map.removeLayer(openspaceLayer);")
  sleep(2)

  # save a screen with the image after the key press
  save_screenshot(map_file2, :selector => "#map")

  # See if the maps now compare
  maps_match = compare_maps(map_file1, map_file2)

  # If they do match, it means there was no map layer
  assert_equal false, maps_match, 'The two map images match, this means they aren\'t on a map layer'

  # Re add the map layer
  page.execute_script("map.addLayer(openspaceLayer);")

end
