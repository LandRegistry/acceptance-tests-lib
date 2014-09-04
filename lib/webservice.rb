def wait_for_register_to_be_created(title_no)
  found = false
  count = 0

  while (found == false && count < 10) do
    puts 'waiting for registration to be created'

    uri = URI.parse($LR_SEARCH_API_DOMAIN)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new('/auth/titles/' + title_no,  initheader = {'Content-Type' =>'application/json'})
    request.basic_auth $http_auth_name, $http_auth_password
    response = http.request(request)

    json_response = JSON.parse(response.body);

    if ((response.code != '404') && (!json_response['title_number'].nil?)) then
        found = true
        puts 'registration created: ' + json_response['title_number']
    else
      sleep(1)
    end

    count = count + 1
  end

  if (found == false) then
    raise "No records found for title " + title_no
  end

  return response.body
end


def link_title_to_email(email, title_number)
  uri = URI.parse($LR_FIXTURES_URL)
  puts $LR_FIXTURES_URL
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/create-matching-data-and-ownership')
  request.basic_auth $http_auth_name, $http_auth_password
  request.set_form_data({'email' => email, 'title_number' => title_number, 'submit' => 'submit'})
  response = http.request(request)

  if (response.body != 'OK') then
    raise "Could not match title(#{title_number}) and email(#{email})"
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


def submit_changeOfName_request(request)

  changeOfName_decission = {}
  changeOfName_decission["action"] = "change-name-marriage"
  changeOfName_decission["data"] = {}
  changeOfName_decission["data"]["iso-country-code"] = $data['countryOfMarriage']
  changeOfName_decission["context"] = {}
  changeOfName_decission["context"]["session-id"] = "123456"
  changeOfName_decission["context"]["transaction-id"] = "ABCDEFG"

  uri = URI.parse('http://decision.landregistry.local')
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/decisions',  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = changeOfName_decission.to_json
  response = http.request(request)

  decission_url = JSON.parse(response.body)['url']

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

  puts decission_url

  uri = URI.parse(decission_url)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = changeOfName_submission.to_json
  response = http.request(request)

  puts response.body

end
