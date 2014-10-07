def create_base_register(table)
  $structuredData = false
  puts $structuredData

  $regData = Hash.new()
  $regData['created_ts'] = DateTime.now.strftime('%Q')
  $regData['title_number'] = titleNumber()
  $regData['proprietorship'] = Hash.new()
  $regData['proprietorship']['template'] = "PROPRIETOR(S): *RP*"
  $regData['proprietorship']['full_text'] = "PROPRIETOR(S): Michael Jones of 8 Miller Way, Plymouth, Devon, PL6 8UQ"
  $regData['proprietorship']['fields'] = Hash.new()
  $regData['proprietorship']['deeds'] = Array.new()
  $regData['proprietorship']['notes'] = Array.new()

  $regData['property_description'] = Hash.new()
  $regData['property_description']['template'] = 'The Freehold land shown edged with red on the plan of the above Title filed at the Registry and being *AD*'
  $regData['property_description']['full_text'] = "The Freehold land shown edged with red on the plan of the above Title filed at the Registry and being 8 Miller Way, Plymouth, Devon, PL6 8UQ"
  $regData['property_description']['fields'] = Hash.new()
  $regData['property_description']['fields']['tenure'] = "Freehold"
  $regData['property_description']['fields'].merge!(generate_address('United Kingdom'))
  $regData['property_description']['deeds'] = Array.new()
  $regData['property_description']['notes'] = Array.new()

  $regData['extent'] = Hash.new()
  $regData['extent'].merge!(genenerate_title_extent2({'has a polygon' => true}))

  add_proprietors(2)

  if (table != '')
    table.raw.each do |value|
      if (value[0] != 'CHARACTERISTICS') then
        if value[0] == 'restictive covenants' then
          add_restrictive_covenants()
        elsif  value[0] == 'bankruptcy notice' then
          add_bankruptcy()
        elsif value[0] == 'easement' then
          add_easement()
        elsif value[0] == 'provision' then
          add_provision()
        elsif value[0] == 'price paid' then
          add_price_paid()
        elsif value[0] == 'restriction' then
          add_restriction()
        elsif value[0] == 'charge' then
          add_charge()
        elsif value[0] == 'other' then
          add_other()
        end
      end
    end
  end

  puts $regData.to_json
  uri = URI.parse($MINT_API_DOMAIN)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new('/titles/' + $regData['title_number'],  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  request.body = $regData.to_json
  response = http.request(request)

  wait_for_register_to_be_created($regData['title_number'])
end

def add_restrictive_covenants()
  $regData['restrictive_covenants'] = Array.new()
  $regData['restrictive_covenants'][0] = Hash.new()
  $regData['restrictive_covenants'][0]['template'] = "By an Order of the Upper Tribunal (Lands Chamber) dated *DA* made pursuant to Section 84 of the Law of Property Act 1925 the restrictive covenants contained in the *DT**DE* dated *DD* referred to above were released. *N< NOTE: Copy Order filed>N*."
  $regData['restrictive_covenants'][0]['full_text'] = "By an Order of the Upper Tribunal (Lands Chamber) dated 14/06/2013 made pursuant to Section 84 of the Law of Property Act 1925 the restrictive covenants contained in the Conveyance dated 01.06.1996 referred to above were released. NOTE: Copy Order filed"
  $regData['restrictive_covenants'][0]['fields'] = Hash.new()
  $regData['restrictive_covenants'][0]['deeds'] = Array.new()
  $regData['restrictive_covenants'][0]['notes'] = Array.new()

  $regData['restrictive_covenants'][1] = Hash.new()
  $regData['restrictive_covenants'][1]['template'] = "By an Order of the Upper Tribunal (Lands Chamber) dated *DA* made pursuant to Section 84 of the Law of Property Act 1925 the restrictive covenants contained in the *DT**DE* dated *DD* referred to above were released. *N< NOTE: Copy Order filed>N*."
  $regData['restrictive_covenants'][1]['full_text'] = "By an Order of the Upper Tribunal (Lands Chamber) dated 14/06/2013 made pursuant to Section 84 of the Law of Property Act 1925 the restrictive covenants contained in the Conveyance dated 01.06.1996 referred to above were released. NOTE: Copy Order filed"
  $regData['restrictive_covenants'][1]['fields'] = Hash.new()
  $regData['restrictive_covenants'][1]['deeds'] = Array.new()
  $regData['restrictive_covenants'][1]['notes'] = Array.new()
end

def add_restriction()
  $regData['restrictions'] = Array.new()
  $regData['restrictions'][0] = Hash.new()
  $regData['restrictions'][0]['template'] = "RESTRICTION: No disposition by the proprietor of the registered estate or in exercise of the power of sale or leasing in any registered charge (except an exempt disposal as defined by section 81(8) of the Housing Act 1988) is to be registered without the consent of - (a) in relation to a disposal of land in England by a private registered provider of social housing, the Regulator of Social Housing, (b) in relation to any other disposal of land in England, the Secretary of State, and (c) in relation to a disposal of land in Wales, the Welsh Ministers, to that disposition under *M<>M*."
  $regData['restrictions'][0]['full_text'] = "RESTRICTION: No disposition by the proprietor of the registered estate or in exercise of the power of sale or leasing in any registered charge (except an exempt disposal as defined by section 81(8) of the Housing Act 1988) is to be registered without the consent of - (a) in relation to a disposal of land in England by a private registered provider of social housing, the Regulator of Social Housing, (b) in relation to any other disposal of land in England, the Secretary of State, and (c) in relation to a disposal of land in Wales, the Welsh Ministers, to that disposition under section 133 of that Act."
  $regData['restrictions'][0]['fields'] = Hash.new()
  $regData['restrictions'][0]['fields']['miscellaneous'] = "section 133 of that Act"
  $regData['restrictions'][0]['deeds'] = Array.new()
  $regData['restrictions'][0]['notes'] = Array.new()
end

def add_bankruptcy()
  $regData['bankruptcy'] = Array.new()
  $regData['bankruptcy'][0] = Hash.new()
  $regData['bankruptcy'][0]['template'] = "BANKRUPTCY NOTICE entered under section 86(2) of the Land Registration Act 2002 in respect of a pending action, as the title of the proprietor of the registered estate appears to be affected by a petition in bankruptcy against *NM* presented in the *M<>M* Court (Court Reference Number *M<>M*) (Land Charges Reference Number PA*M<>M*)."
  $regData['bankruptcy'][0]['full_text'] = "BANKRUPTCY NOTICE entered under section 86(2) of the Land Registration Act 2002 in respect of a pending action, as the title of the proprietor of the registered estate appears to be affected by a petition in bankruptcy against James Lock presented in the Gloucester County Court (Court Reference Number 124578) (Land Charges Reference Number PA102)."
  $regData['bankruptcy'][0]['fields'] = Hash.new()
  $regData['bankruptcy'][0]['deeds'] = Array.new()
  $regData['bankruptcy'][0]['notes'] = Array.new()
end

def add_easement()
  #to generate an easement - genenerate_title_easement2($regData['extent'], {'has a polygon with easement' => true})
  $regData['easements'] = Array.new()
  $regData['easements'][0] = Hash.new()
  $regData['easements'][0]['template'] = "The land *E<>E* is subject to the rights granted by a *DT**DE* dated *DD* made between *DP*. The said Deed also contains restrictive covenants by the grantor. *N<^NOTE: Copy in Certificate. Copy filed>N*."
  $regData['easements'][0]['full_text'] = "The land tinted pink is subject to the rights granted by a Deed dated 03.03.1976 made between Mr Michael Jones and Mr Jeff Smith. The said Deed also contains restrictive covenants by the grantor. NOTE: Copy filed."
  $regData['easements'][0]['fields'] = Hash.new()
  $regData['easements'][0]['deeds'] = Array.new()
  $regData['easements'][0]['notes'] = Array.new()
end

def add_provision()
  $regData['provisions'] = Array.new()
  $regData['provisions'][0] = Hash.new()
  $regData['provisions'][0]['template'] = "A *DT**DE* dated *DD* made between *DP* contains the following provision:-*VT*"
  $regData['provisions'][0]['full_text'] = "A Transfer of the land in this title dated 01.06.1996 made between Mr Michael Jones and Mr Jeff Smith contains the following provision:-The land has the benefit of a right of way along the passageway to the rear of the property, and also a right of way on foot only on to the open ground on the north west boundary of the land in this title"
  $regData['provisions'][0]['fields'] = Hash.new()
  $regData['provisions'][0]['deeds'] = Array.new()
  $regData['provisions'][0]['notes'] = Array.new()
end

def add_price_paid()
  $regData['price_paid'] = Hash.new()
  $regData['price_paid']['template'] = "The price stated to have been paid on *DA* was *AM*."
  $regData['price_paid']['full_text'] = "The price stated to have been paid on 15.11.2005 was 100000."
  $regData['price_paid']['fields'] = Hash.new()
  $regData['price_paid']['fields']['date'] = dateInThePast().strftime("%d/%m/%Y")
  $regData['price_paid']['fields']['amount'] = pricePaid()
  $regData['price_paid']['deeds'] = Array.new()
  $regData['price_paid']['notes'] = Array.new()
end

def add_charge()
  $regData['charges'] = Array.new()
  $regData['charges'][0] = Hash.new()
  $regData['charges'][0]['template'] = "CHARGE"
  $regData['charges'][0]['full_text'] = "CHARGE full text"
  $regData['charges'][0]['fields'] = Hash.new()
  $regData['charges'][0]['deeds'] = Array.new()
  $regData['charges'][0]['notes'] = Array.new()
end

def add_other()
  $regData['other'] = Array.new()
  $regData['other'][0] = Hash.new()
  $regData['other'][0]['template'] = "OTHER"
  $regData['other'][0]['full_text'] = "OTHER full text"
  $regData['other'][0]['fields'] = Hash.new()
  $regData['other'][0]['deeds'] = Array.new()
  $regData['other'][0]['notes'] = Array.new()
end

def add_proprietors(number)
  if $regData['proprietorship']['fields']['proprietors'].nil?
    $regData['proprietorship']['fields']['proprietors'] = Array.new()
  end
  for i in 0..number - 1
    $regData['proprietorship']['fields']['proprietors'][i] = Hash.new()
    $regData['proprietorship']['fields']['proprietors'][i]['name'] = Hash.new()
    $regData['proprietorship']['fields']['proprietors'][i]['name']['title'] = "Mrs"
    $regData['proprietorship']['fields']['proprietors'][i]['name']['full_name'] = fullName()
    $regData['proprietorship']['fields']['proprietors'][i]['name']['decoration'] = ""
    $regData['proprietorship']['fields']['proprietors'][i].merge!(generate_address(countryName()))
  end
end

def generate_address(country)
  house_no = houseNumber().to_s
  street_name = roadName()
  town = townName()
  postal_county = 'Greater London'
  region_name = 'Essex'
  country = country
  postcode = postcode()
  $address = Hash.new()
  $address['address'] = Hash.new()
  $address['address']['full_address'] = "#{house_no} #{street_name}, #{town}, #{postal_county}, #{region_name}, #{country}, #{postcode}"
  $address['address']['house_no'] = ''
  $address['address']['street_name'] = ''
  $address['address']['town'] = ''
  $address['address']['postal_county'] = ''
  $address['address']['region_name'] = ''
  $address['address']['country'] = ''
  $address['address']['postcode'] = ''
  if $structuredData then
    $address['address']['house_no'] = house_no
    $address['address']['street_name'] = street_name
    $address['address']['town'] = town
    $address['address']['postal_county'] = postal_county
    $address['address']['region_name'] = region_name
    $address['address']['country'] = country
    $address['address']['postcode'] = postcode
  end
  return $address
end
