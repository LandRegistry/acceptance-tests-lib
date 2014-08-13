def get_polygon_details(image1, image2)

  # Load the two images that are different (must be the same width and height)
  images = [
    ChunkyPNG::Image.from_file(image2),
    ChunkyPNG::Image.from_file(image1)
  ]

  polygon_data = {}

  polygon_diff = []

  # Get the width and height of the image
  polygon_data['height'] = images.first.height
  polygon_data['width'] = images.first.width

  # Find out the pixels which are different
  images.first.height.times do |y|
    images.first.row(y).each_with_index do |pixel, x|
      polygon_diff << [x,y] unless pixel == images.last[x,y]
    end
  end

  # now with the pixels that are different, get the min and max
  x, y = polygon_diff.map{ |xy| xy[0] }, polygon_diff.map{ |xy| xy[1] }

  polygon_data['x.min'] = x.min
  polygon_data['x.max'] = x.max
  polygon_data['y.min'] = y.min
  polygon_data['y.max'] = y.max

  multi_array = []

  # Loop though all the polygons that are different
  polygon_diff.each do |x, y|

    coords = []

    # We want to check if the polygon has already been checked
    # if it has been checked already it will have been given an id
    for i in 0..(multi_array.count - 1)
      # We want to check the polygon above, below, to the left and to the right of the pixel
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

    # We now have a list of objects that they pixel joins to
    # This could join 2 different sets of pixels (like a U shaped polygon)
    my_polymulti = (coords[0] || -1)

    # If it does join 2 different sets of pixels, it will get 2 different ids. This code below will
    # join those two shapes and give them all the same id
    for i in 0..coords.count - 1
      if ((coords[i] > 0) && (coords[i] != my_polymulti)) then
        multi_array[my_polymulti] = multi_array[my_polymulti].merge(multi_array[coords[i]])
        multi_array.delete(multi_array[coords[i]])
      end
    end

    # Now that we have an id for the pixel, update it's id (by assigning to a new array)
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

  # Duplicate array
  multi_array_cut = multi_array

  # There is a tapering affect on the red pixels, we want to remove some layers of
  # pixels around the edge to get to the solid red border
  layers_to_remove = 1

  # This will loop through and remove layers of the polygon
  for k in 0..(layers_to_remove)
    # set some internal variables
    multi_array_tmp = multi_array_cut
    multi_array_cut = []
    multi_array_area = []
    # This loop will find all the pixels on an edge of a polygon
    # (so where a pixel hasn't got an above or below or left or right pixek)
    # Loop through each polygon
    for i in 0..(multi_array_tmp.count - 1)
      multi_array_cut << {}
      multi_array_area[i] = []
      # Loop though each pixel (x)
      multi_array_tmp[i].each do |poly_key, poly_value |
        # Loop though each pixel (y)
        multi_array_tmp[i][poly_key].each do |poly_object2_key, poly_object2_value|
          # Check if the pixel has an up, down, left, right neghbour
          if ((!multi_array_tmp[i][poly_key][poly_object2_key - 1].nil?) &&
            (!multi_array_tmp[i][poly_key][poly_object2_key + 1].nil?) &&
            ((!multi_array_tmp[i][poly_key - 1].nil?) && (!multi_array_tmp[i][poly_key - 1][poly_object2_key].nil?)) &&
            ((!multi_array_tmp[i][poly_key + 1].nil?) && (!multi_array_tmp[i][poly_key + 1][poly_object2_key].nil?))) then
            if (multi_array_cut[i][poly_key].nil?) then
              multi_array_cut[i][poly_key] = {}
            end
              # If it down have 4 neghbours, then we want to store that in array to possible
              # run through again to remove a layer
              multi_array_cut[i][poly_key][poly_object2_key] = poly_object2_key
          else
            # If it isn't in a layer, then we want to store this and return to the user, as this must be the edging
            multi_array_area[i] << [poly_key, poly_object2_key]
          end
        end

      end

    end

  end

  # This code below will structure the data for returning

  polygon_data['polygons'] = []

  for i in 0..(multi_array.count - 1)

    count = 0

    polys_late = []

    if (!multi_array[i].nil?)
      multi_array[i].each do |poly_key, poly_value |

        multi_array[i][poly_key].each do |poly_object2_key, poly_object2_value|
          count = 1 + count

          polys_late << [poly_key,poly_object2_key]

        end
      end

      x, y = polys_late.map{ |xy| xy[0] }, polys_late.map{ |xy| xy[1] }

      images.last.rect(x.min, y.min, x.max, y.max, ChunkyPNG::Color.rgb(0,0,0))

      # For each polygon return the min/max x and y
      # And a count of the pixels
      # And a list of pixels around the edge
      polygon_data_hash = {}
      polygon_data_hash['x.min'] = x.min
      polygon_data_hash['x.max'] = x.max
      polygon_data_hash['y.min'] = y.min
      polygon_data_hash['y.max'] = y.max
      polygon_data_hash['pixels'] = count
      polygon_data_hash['edging'] = multi_array_area[i]

      polygon_data['polygons'] << polygon_data_hash
    end

  end

  polygon_data['polygon_count'] = polygon_data['polygons'].count

  images.last.save("diff2-#{Time.new.to_i}.png")

  return polygon_data
end

def compare_maps(image1, image2)

  puts 'image1 - ' + Digest::MD5.file(image1).to_s
  puts 'image2 - ' + Digest::MD5.file(image2).to_s

  if (Digest::MD5.file(image1).to_s == Digest::MD5.file(image2).to_s) then
    return true
  else
    return false
  end

end
