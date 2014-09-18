def rest_get_call(url)
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.path,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  response = http.request(request)

  return response
end



def wait_for_register_to_be_created(title_no)
  found_count = 0
  count = 0

  while (found_count != 2 && count < 25) do
    puts 'waiting for registration to be created'

    found_count = 0

    sleep(0.2)

    response = rest_get_call($LR_SEARCH_API_DOMAIN + '/titles/' + title_no)
    json_response = JSON.parse(response.body);

    if ((response.code != '404') && (!json_response['title_number'].nil?)) then
        found_count = found_count + 1
    end

    response = rest_get_call($LR_SEARCH_API_DOMAIN + '/auth/titles/' + title_no)
    json_response = JSON.parse(response.body);

    if ((response.code != '404') && (!json_response['title_number'].nil?)) then
        found_count = found_count + 1
    end

    count = count + 1
  end

  if (found_count != 2) then
    raise "No records found for title " + title_no
  end

  return response.body
end

def get_register_details(title_no)

  response = rest_get_call($LR_SEARCH_API_DOMAIN + '/auth/titles/' + title_no)
  return response.body

end

def link_title_to_email(email, title_number, role)

  $roles = {}
  $roles['CITIZEN'] = '1'
  $roles['CONVEYANCER'] = '2'

  uri = URI.parse($LR_FIXTURES_URL)
  puts $LR_FIXTURES_URL
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/create-matching-data-and-ownership')
  request.basic_auth $http_auth_name, $http_auth_password
  request.set_form_data({'email' => email, 'title_number' => title_number, 'role_id' => $roles[role],'submit' => 'submit'})
  response = http.request(request)

  if (response.body != 'OK') then
    raise "Could not match title(#{title_number}), email(#{email}) and role(#{role}): " + response.body
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
    return false
  else
    return true
  end

end

def create_change_of_name_marriage_request()
  change_of_name = {}
  change_of_name["application_type"] = "change-name-marriage"
  change_of_name["title_number"]  = $regData['title_number']
  change_of_name["submitted_by"] = $regData['proprietors'][0]['full_name']

  change_of_name["request_details"] = {}
  change_of_name["request_details"]["action"] = "change-name-marriage"

  $marriage_data['title'] = $regData
  dateOfMarriage = Date.strptime($marriage_data['marriage_date'], "%d-%m-%Y")
  $marriage_data['marriage_date'] = dateOfMarriage.strftime("%s").to_i
  change_of_name["request_details"]["data"] = $marriage_data.to_json.to_s

  change_of_name["request_details"]["context"] = {}
  change_of_name["request_details"]["context"]["session-id"] = "123456"
  change_of_name["request_details"]["context"]["transaction-id"] = "ABCDEFG"

  uri = URI.parse($DECISION_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/cases',  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = change_of_name.to_json
  response = http.request(request)

end

def wait_for_case_to_exist(title_no)
  found_count = 0
  count = 0

  while (found_count != 1 && count < 25) do
    puts 'waiting for case to be created'
    sleep(0.2)
    response = rest_get_call($DECISION_URL + '/cases/property/' + title_no)
    if (!response.nil?)
      if (!JSON.parse(response.body)[0]['work_queue'].nil?)
        found_count = 1
        puts 'case assigned to ' + JSON.parse(response.body)[0]['work_queue'] + ' queue'
      end
    end
    count = count + 1
  end
  if (found_count != 1) then
    raise "No case found for title " + title_no
  end

  return response.body
end
