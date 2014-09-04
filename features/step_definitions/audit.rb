#Audit for service frontend (when citizen logs in to view)
Then(/^Audit for private citizen register view written$/) do
  url = "https://pull.logentries.com/#{$logentries_key}/hosts/ManualHostService/lr-service-frontend/"

  match_string = "'email': u'citizen@example.org'"
  check_logs_for_message(url, match_string)

  match_string = "request=[<Request 'http://land.service.gov.uk.landregistryconcept.co.uk/property/" + $regData['title_number'] + "' [GET]"
  check_logs_for_message(url, match_string)
end
