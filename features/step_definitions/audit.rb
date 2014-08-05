
#Audit track access written to heroku log and is currently manually tested
#in Heroku/ Add ons/ lr-casework-frontend/ logentries

#Audit for casework when a new 1st registration is created
Then(/^Audit for new registration is written$/) do
  pending # express the regexp above with the code you wish you had
  #Check lr-casework-frontend
  #» 14:57:04.530 2014-08-04 13:57:03.984744+00:00 app web.2 - - Created title number TEST8886 at the mint url http://lr-mint.herokuapp.com//titles/TEST8886: status code 201 Context
  #» 14:57:04.542 2014-08-04 13:57:03.877645+00:00 app web.2 - - Sending data {"title_number": "TEST8886", "payment": {"titles": ["TEST8886"], "price_paid": 65.89}, "proprietors": [{"last_name": "lewis", "first_name": "geoff"}, {"last_name": "", "first_name": ""}], "property": {"class_of_title": "Qualified", "address": {"postcode": "PL7 6FT", "town": "plymouth", "house_number": "790", "road": "melrose"}, "tenure": "Freehold"}, "extent": "{\r\n \"type\": \"Feature\",\r\n \"crs\": {\r\n \"type\": \"name\",\r\n \"properties\": {\r\n \"name\": \"urn:ogc:def:crs:EPSG:27700\"\r\n }\r\n },\r\n \"geometry\": {\r\n \"type\": \"Polygon\",\r\n \"coordinates\":\r\n [[\r\n [404439.5558898761,369899.8484076261], [404440.0558898761,369899.8484076261], [404440.0558898761,369900.3484076261], [404439.5558898761,369900.3484076261], [404439.5558898761,369899.8484076261] ]]\r\n },\r\n \"properties\": {\r\n \"Description\": \"Polygon\"\r\n }\r\n }"} to the mint at http://lr-mint.herokuapp.com//titles/TEST8886 Context
  #» 14:57:04.793 2014-08-04 13:57:04.045566+00:00 app web.1 - - Audit: user=[4], request=[<Request 'http://casework.landregistryconcept.co.uk/registration?created=TEST8886' [GET]>] Context
  #» 14:57:05.005 2014-08-04 13:57:04.112611+00:00 heroku router - - at=info method=GET path="/registration?created=TEST8886" host=casework.landregistryconcept.co.uk request_id=3960a052-48d9-4994-bc60-cdf4dbbf96b3 fwd="109.151.41.82/host109-151-41-82.range109-151.btcentralplus.com" dyno=web.1 connect=1ms service=65ms status=200 bytes=944 Context
  #Title is created
  #shows which caseworker created title
  visit("https://pull.logentries.com/#{$LOGENTRIES_KEY}hosts/Heroku/lr-casework-frontend/?start=$data['AppTime']")
  if (page.body.include? "Audit: user=[4], request=[<Request 'http://casework.landregistryconcept.co.uk/registration?created=" + $data['titleNumber'] + "' [GET]") then
    raise "An audit log to show the creation of title number " + $data['titleNumber'] + " was expected"
  end
end

#Audit for service frontend (when citizen logs in to view)
Then(/^Audit for citizen register view written$/) do
  #» 15:02:02.190 239 <190>1 2014-08-04T14:02:01.868105+00:00 d.59428d99-1c9e-43fe-80d2-cb4b3c8351e9 app web.2 - - Audit: user=[{'email': 'citizen@example.org', 'id': '9'}], request=[<Request 'http://lr-service-frontend.herokuapp.com/property/TEST8886' [GET]>] Context
  #» 15:02:02.192 172 <190>1 2014-08-04T14:02:01.872028+00:00 d.59428d99-1c9e-43fe-80d2-cb4b3c8351e9 app web.2 - - Requesting title url : http://lr-search-api.herokuapp.com/auth/titles/TEST8886 Context
  #» 15:02:02.516 307 <158>1 2014-08-04T14:02:02.277443+00:00 d.59428d99-1c9e-43fe-80d2-cb4b3c8351e9 heroku router - - at=info method=GET path="/property/TEST8886" host=lr-service-frontend.herokuapp.com request_id=c724b014-68f6-4f4d-9643-111d74d3145e fwd="109.151.41.82/host109-151-41-82.range109-151.btcentralplus.com" dyno=web.2 connect=1ms service=424ms status=200 bytes=890 Context
  #» 15:02:02.576 1128 <190>1 2014-08-04T14:02:02.262799+00:00 d.59428d99-1c9e-43fe-80d2-cb4b3c8351e9 app web.2 - - Found the following title: {u'proprietors': [{u'first_name': u'geoff', u'last_name': u'lewis'}, {u'first_name': u'', u'last_name': u''}], u'extent': u'{\r\n "type": "Feature",\r\n "crs": {\r\n "type": "name",\r\n "properties": {\r\n "name": "urn:ogc:def:crs:EPSG:27700"\r\n }\r\n },\r\n "geometry": {\r\n "type": "Polygon",\r\n "coordinates":\r\n [[\r\n [404439.5558898761,369899.8484076261], [404440.0558898761,369899.8484076261], [404440.0558898761,369900.3484076261], [404439.5558898761,369900.3484076261], [404439.5558898761,369899.8484076261] ]]\r\n },\r\n "properties": {\r\n "Description": "Polygon"\r\n }\r\n }', u'title_number': u'TEST8886', u'payment': {u'titles': [u'TEST8886'], u'price_paid': 65.89}, u'previous_sha256': u'cafebabe', u'property': {u'tenure': u'Freehold', u'address': {u'house_number': u'790', u'road': u'melrose', u'town': u'plymouth', u'postcode': u'PL7 6FT'}, u'class_of_title': u'Qualified'}} Context
  #User ID of search
  #Title they requested
end
#Audit for property frontend (when title is searched)
Then(/^Audit for search written$/) do

end
