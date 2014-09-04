def genenerate_title_extent2(polygons)
  $easementCount = 0
  $polycount = 0
  $easementCount = 0
  $polycounteasement = 0

  polydata = Hash.new()
  polydata['type'] = "Feature"
  polydata['crs'] = Hash.new()
  polydata['crs']['type'] = 'name'
  polydata['crs']['properties'] = Hash.new()
  polydata['crs']['properties']['name'] = 'urn:ogc:def:crs:EPSG:27700'
  polydata['geometry'] = Hash.new()

  if (polygons.count > 1) then
    polydata['geometry']['type'] = 'MultiPolygon'
    polydata['geometry']['coordinates'] = Array.new()
    polygons.each do |polygon_type,polygon_value|
      polydata['geometry']['coordinates'] << add_polygon(polygon_type)
    end
  else
    polydata['geometry']['type'] = 'Polygon'
    polydata['geometry']['coordinates'] = add_polygon(polygons.first[0])
  end

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = polydata['geometry']['type']

  $temp_poly_data = polydata

  return polydata
end


def add_polygon(type)

  if ($N.nil?) then
    $N = rand(404431.0 .. 404439.99999)
    $E = rand(369891.0 .. 369899.99999)
  end

  $topLeft = Array.new
  $topLeft << $N
  $topLeft << $E

  $N = $N + 250
  $E = $E + 250

  $bottomRight = Array.new
  $bottomRight << $N
  $bottomRight << $E

  specificPolygon = Array.new()

  if ((type == 'has a polygon with easement') || (type == 'has a polygon'))

    specificPolygon[0] = Array.new()
    specificPolygon[0][0] = Array.new()
    specificPolygon[0][0][0] = $topLeft[0] - rand(0..80)
    specificPolygon[0][0][1] = $topLeft[1] - rand(0..80)
    specificPolygon[0][1] = Array.new()
    specificPolygon[0][1][0] = $bottomRight[0] - rand(0..80)
    specificPolygon[0][1][1] = $topLeft[1] - rand(0..80)
    specificPolygon[0][2] = Array.new()
    specificPolygon[0][2][0] = $bottomRight[0] - rand(0..80)
    specificPolygon[0][2][1] = $bottomRight[1] - rand(0..80)
    specificPolygon[0][3] = Array.new()
    specificPolygon[0][3][0] = $topLeft[0] - rand(0..80)
    specificPolygon[0][3][1] = $bottomRight[1] - rand(0..80)
    specificPolygon[0][4] = Array.new()
    specificPolygon[0][4][0] = specificPolygon[0][0][0]
    specificPolygon[0][4][1] = specificPolygon[0][0][1]

    $easementCount = $easementCount + 1

  elsif (type == 'has a doughnut polygon')

    specificPolygon[0] = Array.new()
    specificPolygon[0][0] = Array.new()
    specificPolygon[0][0][0] = $topLeft[0] - rand(0..80)
    specificPolygon[0][0][1] = $topLeft[1] - rand(0..80)
    specificPolygon[0][1] = Array.new()
    specificPolygon[0][1][0] = $bottomRight[0] - rand(0..80)
    specificPolygon[0][1][1] = $topLeft[1] - rand(0..80)
    specificPolygon[0][2] = Array.new()
    specificPolygon[0][2][0] = $bottomRight[0] - rand(0..80)
    specificPolygon[0][2][1] = $bottomRight[1] - rand(0..80)
    specificPolygon[0][3] = Array.new()
    specificPolygon[0][3][0] = $topLeft[0] - rand(0..80)
    specificPolygon[0][3][1] = $bottomRight[1] - rand(0..80)
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

  $polycount = $polycount + 1

  $E = $E - 320
  $N = $N + 120

  return specificPolygon

end


def genenerate_title_easement2(polygons)

  polydata = Hash.new()
  polydata['type'] = "Feature"
  polydata['crs'] = Hash.new()
  polydata['crs']['type'] = 'name'
  polydata['crs']['properties'] = Hash.new()
  polydata['crs']['properties']['name'] = 'urn:ogc:def:crs:EPSG:27700'
  polydata['geometry'] = Hash.new()


  if ($easementCount > 1) then
    polydata['geometry']['type'] = 'MultiPolygon'
    polydata['geometry']['coordinates'] = Array.new()
    polygons.each do |polygon_type,polygon_value|
      polydata['geometry']['coordinates'] << add_easement_polygon(polygon_type)
    end
  else
    polydata['geometry']['type'] = 'Polygon'
    polydata['geometry']['coordinates'] = add_easement_polygon(polygons.first[0])
  end

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = polydata['geometry']['type']

  return polydata
end


def add_easement_polygon(type)

  $polycounteasement = ($polycounteasement || 0)

  specificPolygon = Array.new()

  if ($polycount > 1) then
    title_extent = $regData['extent']['geometry']['coordinates'][$polycounteasement]
  else
    if (!$regData.nil?)
      title_extent = $regData['extent']['geometry']['coordinates']
    else
      title_extent = $data['title_extent']['geometry']['coordinates']
    end
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

  $polycounteasement = $polycounteasement + 1

  return specificPolygon

end
