Given(/^a registered title with characteristics exists$/) do |table|

  $data_characteristics, $data_characteristics_types = format_data_characteristics(table)

  $regData = Hash.new()
  $regData['title_number'] = titleNumber()
  puts $regData['title_number']

  $regData['proprietors'] = Array.new()
  $regData['proprietors'][0] = Hash.new()
  $regData['proprietors'][0]['full_name'] = fullName()
  $regData['proprietors'][1] = Hash.new()

  if (!$data_characteristics['two proprietors'].nil?)
    $regData['proprietors'][1]['full_name'] = fullName()
  else
    $regData['proprietors'][1]['full_name'] = ''
  end

  $regData['property'] = Hash.new()
  $regData['property']['address'] = Hash.new()
  $regData['property']['address']['address_line_1'] = houseNumber()
  $regData['property']['address']['address_line_2'] = roadName()
  $regData['property']['address']['city'] = townName()
  $regData['property']['address']['postcode'] = postcode()
  $regData['property']['address']['country'] = 'GB'

  $regData['property']['tenure'] = genRegDetails_tenure()
  $regData['property']['class_of_title'] = 'absolute'

  $regData['payment'] = Hash.new()
  $regData['payment']['price_paid'] = pricePaid()
  $regData['payment']['titles'] = Array.new()
  $regData['payment']['titles'][0] = $regData['title_number']

  generate_lease_information()

  generate_charge_information()

  generate_title_extent_information()

  uri = URI.parse($MINT_API_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/titles/' + $regData['title_number'],  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = $regData.to_json
  response = http.request(request)

  if (response.code != '201') then
    raise "Failed creating register: " + response.body
  end

  wait_for_register_to_be_created($regData['title_number'])

end

Given(/^I am the proprietor of a registered title with characteristics$/) do |table|
  step "a registered title with characteristics", table
  link_title_to_email($userdetails['email'], $regData['title_number'], 'CITIZEN')
end

Given(/^a registered title exist$/) do
  step "a registered title with characteristics", ''
end

Given(/^I am the proprietor of a registered title$/) do
  step "a registered title with characteristics", ''
  link_title_to_email($userdetails['email'], $regData['title_number'], 'CITIZEN')
end

Given(/^a registered property$/) do
  step "a registered title with characteristics", ''
end
