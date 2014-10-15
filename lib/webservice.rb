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

  sleep(5) # Temp sleep to try and get Jenkins Working.
  while (found_count != 2 && count < 25) do
    puts 'waiting for registration to be created'

    found_count = 0

    puts 'found_count = ' + found_count.to_s

    sleep(1)

    response = rest_get_call($LR_SEARCH_API_DOMAIN + '/titles/' + title_no)
    json_response = JSON.parse(response.body);
    puts 'json_response = ' + json_response.to_s

    if ((response.code != '404') && (!json_response['title_number'].nil?)) then
        found_count = found_count + 1
    end

    puts 'found_count = ' + found_count.to_s

    response = rest_get_call($LR_SEARCH_API_DOMAIN + '/auth/titles/' + title_no)
    json_response = JSON.parse(response.body);
    puts "json_response = " + json_response.to_s

    if ((response.code != '404') && (!json_response['title_number'].nil?)) then
        found_count = found_count + 1
    end

    count = count + 1
    puts 'count = ' + count.to_s
  end

  if (found_count != 2) then
    raise "No records found for title " + title_no
  end

  return JSON.parse(response.body)
  puts 'JSON.parse(response.body) = ' + JSON.parse(response.body)
end

def get_register_details(title_no)

  response = rest_get_call($LR_SEARCH_API_DOMAIN + '/auth/titles/' + title_no)
  return  JSON.parse(response.body)

end

def link_title_to_email(email, title_number, role)

  $roles = {}
  $roles['CITIZEN'] = '1'
  $roles['CONVEYANCER'] = '2'

  uri = URI.parse($LR_FIXTURES_URL)
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

def wait_for_case_to_exist(title_no)
  found_count = 0
  count = 0

  while (found_count != 1 && count < 25) do
    puts 'waiting for case to be created'
    sleep(1)
    response = rest_get_call($CASES_URL + '/cases/property/' + title_no)
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

def get_token_code(relationship_hash)
  uri = URI.parse($INTRODUCTIONS_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/relationship',  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = relationship_hash.to_json
  response = http.request(request)
  if (response.code != '200') then
    raise "Failed creating relationship: " + response.body
  end
  return JSON.parse(response.body)['token']
end

def getlrid(email)
  uri = URI.parse($LR_FIXTURES_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new('/get-lrid-by-email/' + email)
  request.basic_auth $http_auth_name, $http_auth_password
  response = http.request(request)
  if (response.code != '200') then
    raise "Error in finding email for: " + email
  end
  return response.body
end

def associate_client_with_token(data_hash)
  uri = URI.parse($INTRODUCTIONS_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/confirm',  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = data_hash.to_json
  response = http.request(request)
  if (response.code != '200') then
    raise "Failed to associate client with token: " + response.body
  end
  return response.body
end

def wait_for_register_to_update_full_name(title_number, full_name)

  found_count = 0
  count = 0
  while (found_count != 1 && count < 50) do
    puts 'waiting for new version of title to be created'
    sleep(1)

    response = rest_get_call($LR_SEARCH_API_DOMAIN + '/auth/titles/' + title_number)
    if (response.code.to_s == '200') then

      puts 'name on title: ' + JSON.parse(response.body)['proprietorship']['fields']['proprietors'][0]['name']['full_name']
      puts 'expected name on title: ' + full_name
      if (!response.nil?)
        if (JSON.parse(response.body)['proprietorship']['fields']['proprietors'][0]['name']['full_name']==full_name)
          found_count = 1
          puts 'Title updated'
        end
      end

    end
    count = count + 1
  end
  if (found_count != 1) then
    raise "Title not updated " + title_number
  end

  if ($PERFROMANCETEST.nil?) then
    $function_call_name << 'wait_for_register_to_update_full_name'
    $function_call_data << nil
    $function_call_arguments << {}
    method(__method__).parameters.each do |key, value| $function_call_arguments[$function_call_arguments.count - 1][value.to_s] = decode_value(eval(value.to_s)) end
  end

end

def post_to_historical(data_hash, title_number)
  uri = URI.parse($HISTORIAN_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/' + title_number,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = data_hash.to_json
  response = http.request(request)
  if (response.code != '200') then
    raise "Failed to create the historical data: " + response.body
  end
  return response.body
end

def get_all_history(title_number)
  response = rest_get_call($HISTORIAN_URL + '/' + title_number +'?versions=list')
  if (response.code != '200') then
    raise "Failed to retrieve list of historical data: " + response.body
  end
  return JSON.parse(response.body)
end

def get_history_version(title_number, version)
  uri = URI.parse($HISTORIAN_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new('/' + title_number +'?version=' + version.to_s,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  response = http.request(request)
  if (response.code != '200') then
    raise "Failed to retrieve historical version specified: " + response.body
  end
  return JSON.parse(response.body)
end

def set_user_view_count(email, count)
  uri = URI.parse($LR_FIXTURES_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/set-user-view-count')
  request.basic_auth $http_auth_name, $http_auth_password
  request.set_form_data({'user_view_email' => email, 'view_count' => count.to_s, 'submit' => 'Set view count'})
  response = http.request(request)
  if (response.code != '302') then
    raise "Could not set view count: " + response.body
  end

end
