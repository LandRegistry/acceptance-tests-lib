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

Then(/^there is (\d+) polygon(s|)$/) do |arg1|

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

Then(/^the whole polygon area is in view$/) do

  x, y = $polygon_diff.map{ |xy| xy[0] }, $polygon_diff.map{ |xy| xy[1] }

  image = ChunkyPNG::Image.from_file($polygon_file1)

  assert_not_equal x.min, 0, 'The Polygon occurpys more than the screen'
  assert_not_equal y.min, 0, 'The Polygon occurpys more than the screen'
  assert_not_equal x.max, image.width - 1, 'The Polygon occurpys more than the screen'
  assert_not_equal y.max, image.height - 1, 'The Polygon occurpys more than the screen'

end

Then(/^the polygon(s|) matches that of the title$/) do

end

Then(/^the polygon(s are| is) edged in red$/) do

  assert_equal (find(".//*[local-name() = 'path']")['stroke']) , 'red', 'Expected the edging to be red'

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
  uri = URI.parse($PROPERTY_FRONTEND_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new('/static/build//javascripts/map.js')
  response = http.request(request)
  puts response.body
end

Then(/^the map can't be moved$/) do

end

Then(/^the Polygon(s are| is) laid over a map$/) do

end




Given(/^I am testing$/) do

  $polygon_file1 = "tmpimg-1407416097-1.png"
  $polygon_file2 = "tmpimg-1407416097-2.png"

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

  x, y = $polygon_diff.map{ |xy| xy[0] }, $polygon_diff.map{ |xy| xy[1] }

  multi_array = []

  $polygon_diff.each do |x, y|

    coords = []

    for i in 0..(multi_array.count - 1)

      if (!multi_array[i].nil?)
        if (!multi_array[i][x - 1].nil?) then
          if (!multi_array[i][x - 1][y].nil?) then
            coords << i
          end
        end
        if (!multi_array[i][x + 1].nil?) then
          if (!multi_array[i][x + 1][y].nil?) then
            coords << i
          end
        end
        if (!multi_array[i][x].nil?) then
          if (!multi_array[i][x][y - 1].nil?) then
            coords << i
          end
          if (!multi_array[i][x][y + 1].nil?) then
            coords << i
          end
        end
      end
    end

    my_polymulti = (coords[0] || -1)

    for i in 0..coords.count - 1
      if ((coords[i] > 0) && (coords[i] != my_polymulti)) then
        multi_array[my_polymulti] = multi_array[my_polymulti].merge(multi_array[coords[i]])
        multi_array.delete(multi_array[coords[i]])
      end
    end

    if (my_polymulti > -1) then
      if (multi_array[my_polymulti][x].nil?) then
        multi_array[my_polymulti][x] = {}
      end

      multi_array[my_polymulti][x][y] = y

    else

      multi_array << {}

      if (multi_array.last[x].nil?) then
        multi_array.last[x] = {}
      end

      multi_array.last[x][y] = y

    end

  end

  for i in 0..(multi_array.count - 1)

    polys_late = []

    count = 0

    if (!multi_array[i].nil?)
      multi_array[i].each do |poly_key, poly_valye |

        multi_array[i][poly_key].each do |poly_object2_key, poly_object2_value|
          count = 1 + count

          polys_late << [poly_key,poly_object2_key]

        end
      end

      x, y = polys_late.map{ |xy| xy[0] }, polys_late.map{ |xy| xy[1] }

      images.last.rect(x.min, y.min, x.max, y.max, ChunkyPNG::Color.rgb(0,0,0))

      puts i.to_s + ' ' + count.to_s

    end

  end


  images.last.save("diff2-#{Time.new.to_i}.png")




  puts $polygon_diff.count


  images.last.save("diff2-#{Time.new.to_i}.png")



end
