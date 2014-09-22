def genenerate_title_extent2(data_characteristics)
  polydata = Hash.new()
  polydata['type'] = "Feature"
  polydata['crs'] = Hash.new()
  polydata['crs']['type'] = 'title property'
  polydata['crs']['properties'] = Hash.new()
  polydata['crs']['properties']['name'] = 'urn:ogc:def:crs:EPSG:27700'
  polydata['geometry'] = Hash.new()

  if (count_characteristic_types(data_characteristics, 'polygon') > 1) then
    polydata['geometry']['type'] = 'MultiPolygon'
    polydata['geometry']['coordinates'] = Array.new()
    data_characteristics.each do |polygon_type,polygon_value|
      polydata['geometry']['coordinates'] << add_polygon(polygon_type, polydata)
    end
  else
    polydata['geometry']['type'] = 'Polygon'
    polydata['geometry']['coordinates']= Array.new()
    data_characteristics.each do |polygon_type,polygon_value|
      extent_res = add_polygon(polygon_type, polydata)
      if (extent_res.count > 0)
        polydata['geometry']['coordinates'] = extent_res
      end
    end
  end

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = polydata['geometry']['type']

  return polydata
end


def add_polygon(type, polydata)

  if (polydata['geometry']['coordinates'].count > 0) then
    if (!polydata['geometry']['coordinates'][polydata['geometry']['coordinates'].count - 1][0][0].nil?) then
      temp_coords = polydata['geometry']['coordinates'][polydata['geometry']['coordinates'].count - 1][0][0]
    else
      temp_coords = polydata['geometry']['coordinates'][polydata['geometry']['coordinates'].count - 1][0]
    end
    n = temp_coords[0]
    e = temp_coords[1]
  else
    n = rand(404431.0 .. 404439.99999)
    e = rand(369891.0 .. 369899.99999)
  end

  e = e - 320
  n = n + 120

  topLeft = Array.new
  topLeft << n
  topLeft << e

  n = n + 250
  e = e + 250

  bottomRight = Array.new
  bottomRight << n
  bottomRight << e

  specificPolygon = Array.new()

  if ((type == 'has a polygon with easement') || (type == 'has a polygon'))

    specificPolygon[0] = Array.new()
    specificPolygon[0][0] = Array.new()
    specificPolygon[0][0][0] = topLeft[0] - rand(0..80)
    specificPolygon[0][0][1] = topLeft[1] - rand(0..80)
    specificPolygon[0][1] = Array.new()
    specificPolygon[0][1][0] = bottomRight[0] - rand(0..80)
    specificPolygon[0][1][1] = topLeft[1] - rand(0..80)
    specificPolygon[0][2] = Array.new()
    specificPolygon[0][2][0] = bottomRight[0] - rand(0..80)
    specificPolygon[0][2][1] = bottomRight[1] - rand(0..80)
    specificPolygon[0][3] = Array.new()
    specificPolygon[0][3][0] = topLeft[0] - rand(0..80)
    specificPolygon[0][3][1] = bottomRight[1] - rand(0..80)
    specificPolygon[0][4] = Array.new()
    specificPolygon[0][4][0] = specificPolygon[0][0][0]
    specificPolygon[0][4][1] = specificPolygon[0][0][1]

  elsif (type == 'has a doughnut polygon')

    specificPolygon[0] = Array.new()
    specificPolygon[0][0] = Array.new()
    specificPolygon[0][0][0] = topLeft[0] - rand(0..80)
    specificPolygon[0][0][1] = topLeft[1] - rand(0..80)
    specificPolygon[0][1] = Array.new()
    specificPolygon[0][1][0] = bottomRight[0] - rand(0..80)
    specificPolygon[0][1][1] = topLeft[1] - rand(0..80)
    specificPolygon[0][2] = Array.new()
    specificPolygon[0][2][0] = bottomRight[0] - rand(0..80)
    specificPolygon[0][2][1] = bottomRight[1] - rand(0..80)
    specificPolygon[0][3] = Array.new()
    specificPolygon[0][3][0] = topLeft[0] - rand(0..80)
    specificPolygon[0][3][1] = bottomRight[1] - rand(0..80)
    specificPolygon[0][4] = Array.new()
    specificPolygon[0][4][0] = specificPolygon[0][0][0]
    specificPolygon[0][4][1] = specificPolygon[0][0][1]
    specificPolygon[1] = Array.new()
    specificPolygon[1][0] = Array.new()
    specificPolygon[1][0][0] = specificPolygon[0][0][0] + 70
    specificPolygon[1][0][1] = specificPolygon[0][0][1] + 70
    specificPolygon[1][1] = Array.new()
    specificPolygon[1][1][0] = specificPolygon[0][3][0] + 70
    specificPolygon[1][1][1] = specificPolygon[0][3][1] - 70
    specificPolygon[1][2] = Array.new()
    specificPolygon[1][2][0] = specificPolygon[0][2][0] - 70
    specificPolygon[1][2][1] = specificPolygon[0][2][1] - 70
    specificPolygon[1][3] = Array.new()
    specificPolygon[1][3][0] = specificPolygon[0][1][0] - 70
    specificPolygon[1][3][1] = specificPolygon[0][1][1] + 70
    specificPolygon[1][4] = Array.new()
    specificPolygon[1][4][0] = specificPolygon[1][0][0]
    specificPolygon[1][4][1] = specificPolygon[1][0][1]

  end

  return specificPolygon

end


def genenerate_title_easement2(extentData, data_characteristics)

  polydata = Hash.new()
  polydata['type'] = "Feature"
  polydata['crs'] = Hash.new()
  polydata['crs']['type'] = 'name'
  polydata['crs']['properties'] = Hash.new()
  polydata['crs']['properties']['name'] = 'urn:ogc:def:crs:EPSG:27700'
  polydata['geometry'] = Hash.new()


  if (count_characteristic_types(data_characteristics, 'easement') > 1) then
    polydata['geometry']['type'] = 'MultiPolygon'
    polydata['geometry']['coordinates'] = Array.new()
    data_characteristics.each do |polygon_type,polygon_value|
      polydata['geometry']['coordinates'] << add_easement_polygon(polygon_type, extentData, num)
    end
  else
    polydata['geometry']['type'] = 'Polygon'
    num = 0
    data_characteristics.each do |polygon_type,polygon_value|
      easement_res = add_easement_polygon(polygon_type, extentData, num)
      if (easement_res.count > 0)
        polydata['geometry']['coordinates'] = easement_res
      end
      num += 1
    end
  end

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = polydata['geometry']['type']

  if (!polydata['geometry']['coordinates'][0].nil?)
    return polydata
  else
    return nil
  end
end


def add_easement_polygon(type, extentData, num)

  specificPolygon = Array.new()

  if (extentData['geometry']['coordinates'].count > 1) then
    title_extent = extentData['geometry']['coordinates'][num]
  else
    title_extent = extentData['geometry']['coordinates']
  end

  if (type == 'has a polygon with easement')

    specificPolygon[0] = Array.new()
    specificPolygon[0][0] = Array.new()
    specificPolygon[0][0][0] = title_extent[0][0][0] + 50
    specificPolygon[0][0][1] = title_extent[0][0][1] + 50
    specificPolygon[0][1] = Array.new()
    specificPolygon[0][1][0] = title_extent[0][1][0] - 50
    specificPolygon[0][1][1] = title_extent[0][1][1] + 50
    specificPolygon[0][2] = Array.new()
    specificPolygon[0][2][0] = title_extent[0][2][0] - 50
    specificPolygon[0][2][1] = title_extent[0][2][1] - 50
    specificPolygon[0][3] = Array.new()
    specificPolygon[0][3][0] = title_extent[0][3][0] + 50
    specificPolygon[0][3][1] = title_extent[0][3][1] - 50
    specificPolygon[0][4] = Array.new()
    specificPolygon[0][4][0] = specificPolygon[0][0][0]
    specificPolygon[0][4][1] = specificPolygon[0][0][1]

  end

  return specificPolygon

end
