def titleNumber()
  number = rand(999999999).to_s
  prefix = "TEST"
	return prefix + number
end

def fullName()

	fname = Array.new
	fname << 'Adam'
	fname << 'Bob'
	fname << 'Charles'
	fname << 'Diane'
	fname << 'Eric'
	fname << 'Fiona'
	fname << 'Gareth'
	fname << 'Helen'
	fname << 'Ingrid'
	fname << 'Julie'
	fname << 'Kieran'
	fname << 'Louise'
	fname << 'Michael'
	fname << 'Neil'
	fname << 'Ola'
	fname << 'Peter'
	fname << 'Quincy'
	fname << 'Rachel'
	fname << 'Sam'
	fname << 'Terry'
	fname << 'Una'
	fname << 'Vicky'
	fname << 'Will'
	fname << 'Xavier'
	fname << 'Yvana'
	fname << 'Zach'

	fname_num = rand(0 .. fname.length - 1)

	return fname[fname_num]

end

def postcode()

  pcode = Array.new
  pcode << 'M1 1AA'
  pcode << 'M60 1NW'
  pcode << 'CR2 6XH'
  pcode << 'DN55 1PT'
  pcode << 'W1A 1HQ'
  pcode << 'EC1A 1BB'
  pcode << 'P2 2BB'
  pcode << 'N70 1NX'
  pcode << 'EO66 2QU'
  pcode << 'Y2B 1JR'
  pcode << 'FD2B 2DD'

  pcode_num = rand(0 .. pcode.length - 1)

  return pcode[pcode_num]

end

def houseNumber()
	return rand(1 .. 9999)
end

def roadName()

  road = Array.new
	road << 'Allgood Street'
	road << 'Bardsley Lane (part)'
	road << 'Carlton Drive'
	road << 'Derby Gate'
	road << 'Exmouth Market'
	road << 'Falconberg Mews'
	road << 'Gentian Row'
	road << 'Harrington Way'
	road << 'Iverna Court'
	road << 'Jaspar Road'
	road << 'Kingsmill Terrace'
	road << 'Leitrim Passage'
	road << 'Manor House Road'
	road << 'North End Crescent'
	road << 'Osier Place'
	road << 'Palace Gardens Terrace'
	road << 'Quick Street'
	road << 'Richmond Terrace Mews'
	road << "St. Anselm's Place"
	road << 'Trinity Church Square'
	road << 'Upper Tulse Hill'
	road << 'Victoria Rise'
	road << 'Waverley Crescent'
	road << 'Yoakley Road'
	road << 'Vauxhall Grove'
	road << 'Zealand Road'

	road_num = rand(0 .. road.length - 1)

	return road[road_num]

end

def townName()

  town = Array.new
	town << 'Abercwmboi'
	town << 'Bridgend'
	town << 'Crickhowell'
	town << "Dinnington St John's"
	town << 'East Retford'
	town << 'Fordbridge'
	town << 'Grange-over-Sands'
	town << 'Hay-on-Wye'
	town << 'Ivybridge'
	town << 'Jarrow'
	town << 'Kirkby-in-Ashfield'
	town << 'Lyme Regis'
	town << 'Malmesbury'
	town << 'Needham Market'
	town << 'Ollerton and Boughton'
	town << 'Penrith'
	town << 'Queenborough-in-Sheppey'
	town << 'Rayleigh'
	town << "St Just-in-Penwith"
	town << 'Tewkesbury'
	town << 'Upton-upon-Severn'
	town << 'Ventnor'
	town << 'Walton-on-Thames'
	town << 'Yate'
	town << 'Telford'
	town << 'Torquay'

	town_num = rand(0 .. town.length - 1)

	return town[town_num]
end

def pricePaid()
	return rand(100000 .. 9999000)
end

def generate_single_extent
  $N = rand(404431.0 .. 404439.99999)
  $E = rand(369891.0 .. 369899.99999)

  polydata = Hash.new()
  polydata['type'] = "Feature"
  polydata['crs'] = Hash.new()
  polydata['crs']['type'] = 'name'
  polydata['crs']['properties'] = Hash.new()
  polydata['crs']['properties']['name'] = 'urn:ogc:def:crs:EPSG:27700'
  polydata['geometry'] = Hash.new()

  polydata['geometry']['type'] = 'Polygon'
  polydata['geometry']['coordinates'] = Array.new()

  $topLeft = Array.new
  $topLeft << $N
  $topLeft << $E

  $N = $N + 250
  $E = $E + 250

  $bottomRight = Array.new
  $bottomRight << $N
  $bottomRight << $E

  polydata['geometry']['coordinates'][0] = Array.new()
  polydata['geometry']['coordinates'][0][0] = Array.new()
  polydata['geometry']['coordinates'][0][0][0] = $topLeft[0] - rand(0..80)
  polydata['geometry']['coordinates'][0][0][1] = $topLeft[1] - rand(0..80)
  polydata['geometry']['coordinates'][0][1] = Array.new()
  polydata['geometry']['coordinates'][0][1][0] = $bottomRight[0] - rand(0..80)
  polydata['geometry']['coordinates'][0][1][1] = $topLeft[1] - rand(0..80)
  polydata['geometry']['coordinates'][0][2] = Array.new()
  polydata['geometry']['coordinates'][0][2][0] = $bottomRight[0] - rand(0..80)
  polydata['geometry']['coordinates'][0][2][1] = $bottomRight[1] - rand(0..80)
  polydata['geometry']['coordinates'][0][3] = Array.new()
  polydata['geometry']['coordinates'][0][3][0] = $topLeft[0] - rand(0..80)
  polydata['geometry']['coordinates'][0][3][1] = $bottomRight[1] - rand(0..80)
  polydata['geometry']['coordinates'][0][4] = Array.new()
  polydata['geometry']['coordinates'][0][4][0] = polydata['geometry']['coordinates'][0][0][0]
  polydata['geometry']['coordinates'][0][4][1] = polydata['geometry']['coordinates'][0][0][1]

  $N = $N + 250

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = 'Polygon'

  return polydata

end

#function determines if single polygon or multipolygon and returns result
def genenerate_title_extent(polygons)
  if polygons == 1 then
    polydata = generate_single_extent
  else
    polydata = genenerate_multiple_extent(polygons)
  end
  return polydata
end

def genenerate_multiple_extent(polygons)
   $N = rand(404431.0 .. 404439.99999)
   $E = rand(369891.0 .. 369899.99999)

   polydata = Hash.new()
   polydata['type'] = "Feature"
   polydata['crs'] = Hash.new()
   polydata['crs']['type'] = 'name'
   polydata['crs']['properties'] = Hash.new()
   polydata['crs']['properties']['name'] = 'urn:ogc:def:crs:EPSG:27700'
   polydata['geometry'] = Hash.new()
   #the gemoetry is listed differently for multi pologons instead of a single polygon
   polydata['geometry']['type'] = 'MultiPolygon'
   polydata['geometry']['coordinates'] = Array.new()


   for i in 0..(polygons - 1)

    $topLeft = Array.new
    $topLeft << $N
    $topLeft << $E

    $N = $N + 250
    $E = $E + 250

    $bottomRight = Array.new
    $bottomRight << $N
    $bottomRight << $E
     j = i
     puts j

     polydata['geometry']['coordinates'][i] = Array.new()
     polydata['geometry']['coordinates'][i][0] = Array.new()
     polydata['geometry']['coordinates'][i][0][0] = Array.new()
     polydata['geometry']['coordinates'][i][0][0][0] = $topLeft[0] - rand(0..80)
     polydata['geometry']['coordinates'][i][0][0][1] = $topLeft[1] - rand(0..80)
     polydata['geometry']['coordinates'][i][0][1] = Array.new()
     polydata['geometry']['coordinates'][i][0][1][0] = $bottomRight[0] - rand(0..80)
     polydata['geometry']['coordinates'][i][0][1][1] = $topLeft[1] - rand(0..80)
     polydata['geometry']['coordinates'][i][0][2] = Array.new()
     polydata['geometry']['coordinates'][i][0][2][0] = $bottomRight[0] - rand(0..80)
     polydata['geometry']['coordinates'][i][0][2][1] = $bottomRight[1] - rand(0..80)
     polydata['geometry']['coordinates'][i][0][3] = Array.new()
     polydata['geometry']['coordinates'][i][0][3][0] = $topLeft[0] - rand(0..80)
     polydata['geometry']['coordinates'][i][0][3][1] = $bottomRight[1] - rand(0..80)
     polydata['geometry']['coordinates'][i][0][4] = Array.new()
     polydata['geometry']['coordinates'][i][0][4][0] = polydata['geometry']['coordinates'][j][0][0][0]
     polydata['geometry']['coordinates'][i][0][4][1] = polydata['geometry']['coordinates'][j][0][0][1]

     $N = $N + 250

  end

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = 'MultiPolygon'

  puts polydata

 return polydata

end


def dateInThePast()
  return DateTime.now - (rand(1..99))
end


def countryName()

  country = Array.new
  country << 'Finland'
  country << 'France'
  country << 'Georgia'
  country << 'Germany'
  country << 'Greece'
  country << 'Italyv'
  country << 'Monaco'
  country << 'Norway'
  country << 'Portugal'
  country << 'Ukraine'
  country << 'United Kingdom'

  country_num = rand(0 .. country.length - 1)

  return country[country_num]

end

def certificateNumber()
  return rand(1000000000..9000000000)
end

def genenerate_title_extent_donut(polygons)
  $N = rand(404431.0 .. 404439.99999)
  $E = rand(369891.0 .. 369899.99999)

  polydata = Hash.new()
  polydata['type'] = "Feature"
  polydata['crs'] = Hash.new()
  polydata['crs']['type'] = 'name'
  polydata['crs']['properties'] = Hash.new()
  polydata['crs']['properties']['name'] = 'urn:ogc:def:crs:EPSG:27700'
  polydata['geometry'] = Hash.new()
  polydata['geometry']['type'] = 'Polygon'
  polydata['geometry']['coordinates'] = Array.new()

  $topLeft = Array.new
  $topLeft << $N
  $topLeft << $E

  $N = $N + 250
  $E = $E + 250

  $bottomRight = Array.new
  $bottomRight << $N
  $bottomRight << $E

  polydata['geometry']['coordinates'][0] = Array.new()
  polydata['geometry']['coordinates'][0][0] = Array.new()
  polydata['geometry']['coordinates'][0][0][0] = $topLeft[0] - rand(0..80)
  polydata['geometry']['coordinates'][0][0][1] = $topLeft[1] - rand(0..80)
  polydata['geometry']['coordinates'][0][1] = Array.new()
  polydata['geometry']['coordinates'][0][1][0] = $bottomRight[0] - rand(0..80)
  polydata['geometry']['coordinates'][0][1][1] = $topLeft[1] - rand(0..80)
  polydata['geometry']['coordinates'][0][2] = Array.new()
  polydata['geometry']['coordinates'][0][2][0] = $bottomRight[0] - rand(0..80)
  polydata['geometry']['coordinates'][0][2][1] = $bottomRight[1] - rand(0..80)
  polydata['geometry']['coordinates'][0][3] = Array.new()
  polydata['geometry']['coordinates'][0][3][0] = $topLeft[0] - rand(0..80)
  polydata['geometry']['coordinates'][0][3][1] = $bottomRight[1] - rand(0..80)
  polydata['geometry']['coordinates'][0][4] = Array.new()
  polydata['geometry']['coordinates'][0][4][0] = polydata['geometry']['coordinates'][0][0][0]
  polydata['geometry']['coordinates'][0][4][1] = polydata['geometry']['coordinates'][0][0][1]
  polydata['geometry']['coordinates'][1] = Array.new()
  polydata['geometry']['coordinates'][1][0] = Array.new()
  polydata['geometry']['coordinates'][1][0][0] = polydata['geometry']['coordinates'][0][0][0] + 70
  polydata['geometry']['coordinates'][1][0][1] = polydata['geometry']['coordinates'][0][0][1] + 70
  polydata['geometry']['coordinates'][1][1] = Array.new()
  polydata['geometry']['coordinates'][1][1][0] = polydata['geometry']['coordinates'][0][3][0] + 70
  polydata['geometry']['coordinates'][1][1][1] = polydata['geometry']['coordinates'][0][3][1] - 70
  polydata['geometry']['coordinates'][1][2] = Array.new()
  polydata['geometry']['coordinates'][1][2][0] = polydata['geometry']['coordinates'][0][2][0] - 70
  polydata['geometry']['coordinates'][1][2][1] = polydata['geometry']['coordinates'][0][2][1] - 70
  polydata['geometry']['coordinates'][1][3] = Array.new()
  polydata['geometry']['coordinates'][1][3][0] = polydata['geometry']['coordinates'][0][1][0] - 70
  polydata['geometry']['coordinates'][1][3][1] = polydata['geometry']['coordinates'][0][1][1] + 70
  polydata['geometry']['coordinates'][1][4] = Array.new()
  polydata['geometry']['coordinates'][1][4][0] = polydata['geometry']['coordinates'][1][0][0]
  polydata['geometry']['coordinates'][1][4][1] = polydata['geometry']['coordinates'][1][0][1]

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = 'Polygon'
  return polydata
end



def generate_easement_for_title_extent(title_extent)

  polydata = Hash.new()
  polydata['type'] = "Feature"
  polydata['crs'] = Hash.new()
  polydata['crs']['type'] = 'name'
  polydata['crs']['properties'] = Hash.new()
  polydata['crs']['properties']['name'] = 'urn:ogc:def:crs:EPSG:27700'
  polydata['geometry'] = Hash.new()

  polydata['geometry']['type'] = 'Polygon'
  polydata['geometry']['coordinates'] = Array.new()

  polydata['geometry']['coordinates'][0] = Array.new()
  polydata['geometry']['coordinates'][0][0] = Array.new()
  polydata['geometry']['coordinates'][0][0][0] = title_extent['geometry']['coordinates'][0][0][0] + 50
  polydata['geometry']['coordinates'][0][0][1] = title_extent['geometry']['coordinates'][0][0][1] + 50
  polydata['geometry']['coordinates'][0][1] = Array.new()
  polydata['geometry']['coordinates'][0][1][0] = title_extent['geometry']['coordinates'][0][1][0] - 50
  polydata['geometry']['coordinates'][0][1][1] = title_extent['geometry']['coordinates'][0][1][1] + 50
  polydata['geometry']['coordinates'][0][2] = Array.new()
  polydata['geometry']['coordinates'][0][2][0] = title_extent['geometry']['coordinates'][0][2][0] - 50
  polydata['geometry']['coordinates'][0][2][1] = title_extent['geometry']['coordinates'][0][2][1] - 50
  polydata['geometry']['coordinates'][0][3] = Array.new()
  polydata['geometry']['coordinates'][0][3][0] = title_extent['geometry']['coordinates'][0][3][0] + 50
  polydata['geometry']['coordinates'][0][3][1] = title_extent['geometry']['coordinates'][0][3][1] - 50
  polydata['geometry']['coordinates'][0][4] = Array.new()
  polydata['geometry']['coordinates'][0][4][0] = polydata['geometry']['coordinates'][0][0][0]
  polydata['geometry']['coordinates'][0][4][1] = polydata['geometry']['coordinates'][0][0][1]

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = 'Polygon'

  return polydata

end

def generate_multiple_easement_for_title_extent(title_extent, polygons)

  polydata = Hash.new()
  polydata['type'] = "Feature"
  polydata['crs'] = Hash.new()
  polydata['crs']['type'] = 'name'
  polydata['crs']['properties'] = Hash.new()
  polydata['crs']['properties']['name'] = 'urn:ogc:def:crs:EPSG:27700'
  polydata['geometry'] = Hash.new()

  polydata['geometry']['type'] = 'MultiPolygon'
  polydata['geometry']['coordinates'] = Array.new()

  for i in 0..(polygons - 1)

    polydata['geometry']['coordinates'][i] = Array.new
    polydata['geometry']['coordinates'][i][0] = Array.new()
    polydata['geometry']['coordinates'][i][0][0] = Array.new()
    polydata['geometry']['coordinates'][i][0][0][0] = title_extent['geometry']['coordinates'][0][0][0] + 100
    polydata['geometry']['coordinates'][i][0][0][1] = title_extent['geometry']['coordinates'][0][0][1] + 75 + (i * 80)
    polydata['geometry']['coordinates'][i][0][1] = Array.new()
    polydata['geometry']['coordinates'][i][0][1][0] = polydata['geometry']['coordinates'][i][0][0][0] + 50 - rand(0..10)
    polydata['geometry']['coordinates'][i][0][1][1] = polydata['geometry']['coordinates'][i][0][0][1] - rand(0..10)
    polydata['geometry']['coordinates'][i][0][2] = Array.new()
    polydata['geometry']['coordinates'][i][0][2][0] = polydata['geometry']['coordinates'][i][0][1][0] - rand(0..10)
    polydata['geometry']['coordinates'][i][0][2][1] = polydata['geometry']['coordinates'][i][0][1][1] + 50 - rand(0..10)
    polydata['geometry']['coordinates'][i][0][3] = Array.new()
    polydata['geometry']['coordinates'][i][0][3][0] = polydata['geometry']['coordinates'][i][0][0][0] + rand(0..10)
    polydata['geometry']['coordinates'][i][0][3][1] = polydata['geometry']['coordinates'][i][0][0][1] + 50 - rand(0..10)
    polydata['geometry']['coordinates'][i][0][4] = Array.new()
    polydata['geometry']['coordinates'][i][0][4][0] = polydata['geometry']['coordinates'][i][0][0][0]
    polydata['geometry']['coordinates'][i][0][4][1] = polydata['geometry']['coordinates'][i][0][0][1]

  end

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = 'MultiPolygon'

  puts polydata.to_json

  return polydata

end


def genenerate_title_extent2(polygons)



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
    polydata['geometry']['coordinates'] = add_polygon(polygons.first)
  end

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = polydata['geometry']['type']

  puts polydata.to_json

  return polydata
end


def add_polygon(type)

  $polycount = ($polycount || 0)

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

  if ((type == 'polygon with easement') || (type == 'polygon'))

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

    $easementCount = ($easementCount || 0) + 1

  elsif (type == 'doughnut polygon')

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

  $E = $E
  $N = $N + 120
  return specificPolygon

end


def genenerate_title_easement2(polygons)

  $easementCount = ($easementCount || 0)

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
    polydata['geometry']['coordinates'] = add_easement_polygon(polygons.first)
  end

  polydata['geometry']['properties'] = Hash.new()
  polydata['geometry']['properties']['Description'] = polydata['geometry']['type']

  puts polydata.to_json

  return polydata
end


def add_easement_polygon(type)

  $polycounteasement = ($polycounteasement || 0)

  specificPolygon = Array.new()

puts $regData['extent']['geometry']['coordinates']

  if ($polycount > 0) then
    title_extent = $regData['extent']['geometry']['coordinates'][$polycounteasement]
  else
    title_extent = $regData['extent']['geometry']['coordinates']
  end

  if (type == 'polygon with easement')

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
