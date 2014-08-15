
#Audit for casework when a new 1st registration is created
Then(/^Audit for new registration is written$/) do
  url = "https://pull.logentries.com/#{$logentries_key}/hosts/Heroku/lr-casework-frontend/"

  match_string = "'email': 'caseworker@example.org'"
  check_logs_for_message(url, match_string)
  match_string = "request=[<Request 'http://casework.landregistryconcept.co.uk/registration?created=" + $data['titleNumber'].to_s + "' [GET]"
  check_logs_for_message(url, match_string)
end

#Audit for service frontend (when citizen logs in to view)
Then(/^Audit for private citizen register view written$/) do
  url = "https://pull.logentries.com/#{$logentries_key}/hosts/ManualHostService/lr-service-frontend/"

  match_string = "'email': 'citizen@example.org'"
  check_logs_for_message(url, match_string)

  match_string = "request=[<Request 'http://land.service.gov.uk.landregistryconcept.co.uk/property/" + $regData['title_number'] + "' [GET]"
  check_logs_for_message(url, match_string)
end

#Audit for property frontend (when title is displayed)
Then(/^Audit for public citizen search of title written$/) do
  url = "https://pull.logentries.com/#{$logentries_key}/hosts/ManualHostProperty/lr-property-frontend/"
  match_string = "Audit: user=[anon], request=[<Request 'http://www.gov.uk.landregistryconcept.co.uk/property/" + $regData['title_number'] + "' [GET]"
  check_logs_for_message(url, match_string)
end
