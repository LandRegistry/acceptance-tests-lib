def titleNumber()
  number = rand(99999).to_s
  prefix = "TEST"
	return prefix + number
end

def firstName()

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

def surname()

  sname = Array.new
	sname << 'Adams'
	sname << 'Brown'
	sname << 'Cook'
	sname << 'Drane'
	sname << 'Elf'
	sname << 'Fisher'
	sname << 'Green'
	sname << 'Hall'
	sname << 'Island'
	sname << 'Jackson'
	sname << 'King'
	sname << 'Large'
	sname << 'Matthews'
	sname << 'Neilson'
	sname << 'Onion'
	sname << 'Parrett'
	sname << 'Quest'
	sname << 'Richardson'
	sname << 'Smith'
	sname << 'Tibbs'
	sname << 'Usher'
	sname << 'Vallance'
	sname << 'Wallis'
	sname << 'Xavier'
	sname << 'Yankee'
	sname << 'Zulu'

	sname_num = rand(0 .. sname.length - 1)

	return sname[sname_num]

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

def genenerate_title_extent()
 $N = rand(404431.0 .. 404439.99999)
 $E = rand(369891.0 .. 369899.99999)


 $topLeft = Array.new
 $topLeft << $N.to_s
 $topLeft << $E.to_s

 $N = $N + 0.5
 $E = $E + 0.5

 $bottomRight = Array.new
 $bottomRight << $N.to_s
 $bottomRight << $E.to_s

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
 polydata['geometry']['coordinates'][0][0][0] = $topLeft[0]
 polydata['geometry']['coordinates'][0][0][1] = $topLeft[1]
 polydata['geometry']['coordinates'][0][1] = Array.new()
 polydata['geometry']['coordinates'][0][1][0] = $bottomRight[0]
 polydata['geometry']['coordinates'][0][1][1] = $topLeft[1]
 polydata['geometry']['coordinates'][0][2] = Array.new()
 polydata['geometry']['coordinates'][0][2][0] = $bottomRight[0]
 polydata['geometry']['coordinates'][0][2][1] = $bottomRight[1]
 polydata['geometry']['coordinates'][0][3] = Array.new()
 polydata['geometry']['coordinates'][0][3][0] = $topLeft[0]
 polydata['geometry']['coordinates'][0][3][1] = $bottomRight[1]
 polydata['geometry']['coordinates'][0][4] = Array.new()
 polydata['geometry']['coordinates'][0][4][0] = $topLeft[0]
 polydata['geometry']['coordinates'][0][4][1] = $topLeft[1]
 polydata['geometry']['properties'] = Hash.new()
 polydata['geometry']['properties']['Description'] = 'Polygon'

 return polydata
=begin

$rectBegin = <<eos
{
 "type": "Feature",
 "crs": {
   "type": "name",
   "properties": {
     "name": "urn:ogc:def:crs:EPSG:27700"
   }
 },
 "geometry": {
   "type": "Polygon",
   "coordinates":
       [[
eos

$rectEnd = <<eos
]]
},
"properties": {
"Description": "Polygon"
}
}
eos
 $rectangle = $rectBegin + "["+ $topLeft[0] + "," + $topLeft[1] + "], "
 $rectangle = $rectangle + "["+ $bottomRight[0] + "," + $topLeft[1] + "], "
 $rectangle = $rectangle + "["+ $bottomRight[0] + "," + $bottomRight[1] + "], "
 $rectangle = $rectangle + "["+ $topLeft[0] + "," + $bottomRight[1] + "], "
 $rectangle = $rectangle + "["+ $topLeft[0] + "," + $topLeft[1] + "] "
 $rectangle = $rectangle + $rectEnd
=end
end
