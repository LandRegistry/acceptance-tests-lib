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

  puts title_no

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
  $marriage_data['marriage_date'] = dateOfMarriage.strftime("%s").to_s


  #$marriage_data = $marriage_data['marriage_date'].strftime("%s")
  change_of_name["request_details"]["data"] = $marriage_data.to_json.to_s

  change_of_name["request_details"]["context"] = {}
  change_of_name["request_details"]["context"]["session-id"] = "123456"
  change_of_name["request_details"]["context"]["transaction-id"] = "ABCDEFG"

  puts change_of_name.to_json

  uri = URI.parse($DECISION_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/cases',  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = change_of_name.to_json
  response = http.request(request)

end

def submit_changeOfName_request(request)

  changeOfName_decission = {}
  changeOfName_decission["action"] = "change-name-marriage"
  changeOfName_decission["data"] = {}
  changeOfName_decission["data"]["iso-country-code"] = $data['countryOfMarriage']
  changeOfName_decission["context"] = {}
  changeOfName_decission["context"]["session-id"] = "123456"
  changeOfName_decission["context"]["transaction-id"] = "ABCDEFG"

  uri = URI.parse($DECISION_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/decisions',  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = changeOfName_decission.to_json
  response = http.request(request)

  decision_forward_url = JSON.parse(response.body)['url']

  changeOfName_submission = {}
  changeOfName_submission['marriage_country'] = $data['countryOfMarriage']
  changeOfName_submission['partner_name'] = $data['partnerFullName']
  changeOfName_submission['application_type'] = 'change-name-marriage'
  changeOfName_submission['confirm'] = true
  changeOfName_submission['proprietor_new_full_name'] = $data['newName']
  changeOfName_submission['marriage_place'] = $data['locationOfMarriage']
  changeOfName_submission['title_number'] = $regData['title_number']
  changeOfName_submission['marriage_certificate_number'] = $data['marriageCertificateNumber']
  changeOfName_submission['proprietor_previous_full_name'] = $regData['proprietors'][0]['full_name']
  changeOfName_submission['marriage_date'] = Date.today.to_time.to_i

  puts decision_forward_url

  uri = URI.parse(decision_forward_url)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = changeOfName_submission.to_json
  response = http.request(request)

  puts response.body

end
