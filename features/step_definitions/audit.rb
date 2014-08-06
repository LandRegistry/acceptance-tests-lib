
#Audit track access written to heroku log and is currently manually tested
#in Heroku/ Add ons/ lr-casework-frontend/ logentries

#uri = URI.parse($LR_SEARCH_API_DOMAIN)
#http = Net::HTTP.new(uri.host, uri.port)
#request = Net::HTTP::Get.new('/search?query=' + title_no,  initheader = {'Content-Type' =>'application/json'})
#request.basic_auth $http_auth_name, $http_auth_password
#response = http.request(request)

#Audit for casework when a new 1st registration is created
Then(/^Audit for new registration is written$/) do
  #Check lr-casework-frontend
  #Title is created
  #shows which caseworker created title
  if $ENVIRONMENT = "preview" then
    #puts $data['AppTime']
    visit("https://pull.logentries.com/#{$LOGENTRIES_KEY}hosts/Heroku/lr-casework-frontend/?start=$data['AppTime']")
    if (page.body.include? "Audit: user=[{'email': 'caseworker@example.org', 'id': '4'}], request=[<Request 'http://casework.landregistryconcept.co.uk/registration?created=" + $data['titleNumber'] + "' [GET]") then
      raise "An audit log to show the creation of title number " + $data['titleNumber'] + " was expected but not written"
    end
    else
      puts "Audit for creation of register not currently checked in development environment"
      #Need to add search for local logs in dev
  end
end

#Audit for service frontend (when citizen logs in to view)
Then(/^Audit for private citizen register view written$/) do
  if $ENVIRONMENT = "preview" then
    #puts $data['AppTime']
    visit("https://pull.logentries.com/#{$LOGENTRIES_KEY}hosts/Heroku/lr-service-frontend/?start=$data['AppTime']")
    if (page.body.include? "Audit: user=[{'email': 'citizen@example.org', 'id': '9'}], request=[<Request 'http://lr-service-frontend.herokuapp.com/property/" + $data['titleNumber'] + "' [GET]") then
      raise "An audit log to show the citizen has signed in and viewed the title number " + $data['titleNumber'] + " was expected but not written"
    end
    else
      puts "Audit for private citizen viewing register not currently checked in development environment"
      #Need to add search for local logs in dev
  end
end
#Audit for property frontend (when title is searched)
Then(/^Audit for public citizen search of title written$/) do
  if $ENVIRONMENT = "preview" then
    #puts $data['AppTime']
    visit("https://pull.logentries.com/#{$LOGENTRIES_KEY}hosts/Heroku/lr-property-frontend/?start=$data['AppTime']")
    if (page.body.include? "Audit: user=[anon], request=[<Request 'http://www.gov.uk.landregistryconcept.co.uk/property/" + $data['titleNumber'] + "' [GET]") then
      raise "An audit log to show public search and view of title number " + $data['titleNumber'] + " was expected but not written"
    end
    else
      puts "Audit for public search and view of register not currently checked in development environment"
      #Need to add search for local logs in dev
  end
end
