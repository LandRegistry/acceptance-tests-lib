def wait_for_register_to_be_created(title_no)
  found = false
  count = 0
  while (found == false && count < 10) do
  puts 'waiting for registration to be created'

  uri = URI.parse($LR_SEARCH_API_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new('/search?query=' + title_no,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  response = http.request(request)

  json_response = JSON.parse(response.body);

  if ((response.code != '404') && (json_response['results'].length > 0)) then
      found = true
      puts 'registration created'
  end

  count = count + 1
  sleep(1)
end

  if (found == false) then
    raise "No records found for title " + title_no
  end
end

def get_register_by_title(title_no)
  uri = URI.parse($SYSTEM_OF_RECORD_API_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new('/titles/' + title_no,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = $regData.to_json
  response = http.request(request)

  if (response.code == '404') then
    raise "Title " + title_no + " does not exist"
  else
    puts 'registration found'
    # Not sure why Ruby is having an issue parsing the python json output
    #json_response = JSON.parse(response.body.gsub(/u'(.*?)'/, '"\1"').gsub(/u"(.*?)"/, '"\1"').gsub(/\\\\r/, '').gsub(/\\\\n/, '').gsub(/"data": "/, '"data": ').gsub(/"price_paid": (.*?)}}}",/, '"price_paid": \1}}},').gsub(/ None/, '""').gsub(/"road": u\"(.*?)\"/, '"raod": "\1"'));
    response.body
  end

end

def does_title_exist(title_no)
  puts 'Does title exist'

  uri = URI.parse($SYSTEM_OF_RECORD_API_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new('/titles/' + title_no,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = $regData.to_json
  response = http.request(request)

  if (response.code == '404') then
    puts 'Title does not exist'
    false
  else
    puts 'Title exists'
    true
  end

end
