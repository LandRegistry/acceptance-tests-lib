def create_base_register()
  $registerData['proprietorship'] = Hash.new()
  $registerData['proprietorship']['text'] = "PROPRIETOR(S): *RP*"
  $registerData['proprietorship']['full_text'] = "PROPRIETOR(S): Michael Jones of 8 Miller Way, Plymouth, Devon, PL6 8UQ"
  $registerData['proprietorship']['fields'] = Hash.new()
  $registerData['proprietorship']['deeds'] = Array.new()
  $registerData['proprietorship']['notes'] = Array.new()

  $registerData['property_description'] = Hash.new()
  $registerData['property_description']['text'] = 'The Freehold land shown edged with red on the plan of the above Title filed at the Registry and being *AD*'
  $registerData['property_description']['full_text'] = "The Freehold land shown edged with red on the plan of the above Title filed at the Registry and being 8 Miller Way, Plymouth, Devon, PL6 8UQ"
  $registerData['property_description']['fields'] = Hash.new()
  $registerData['property_description']['fields']['tenure'] = "Freehold"
  $registerData['property_description']['fields'].merge!(generate_address(''))
  $registerData['property_description']['deeds'] = Array.new()
  $registerData['property_description']['notes'] = Array.new()

  $registerData['extent'] = Hash.new()
  $registerData['extent'].merge!(genenerate_title_extent2({'has a polygon' => true}))

end

def add_restrictive_covenants()
  $registerData['restrictive_covenants'] = Array.new()
  $registerData['restrictive_covenants'][0] = Hash.new()
  $registerData['restrictive_covenants'][0]['text'] = "A *DT**DE* dated *DD* made between *DP* contains the following provision:-*VT*"
  $registerData['restrictive_covenants'][0]['full_text'] = "By an Order of the Upper Tribunal (Lands Chamber) dated 14/06/2013 made pursuant to Section 84 of the Law of Property Act 1925 the restrictive covenants contained in the Conveyance dated 01.06.1996 referred to above were released. NOTE: Copy Order filed"
  $registerData['restrictive_covenants'][0]['fields'] = Hash.new()
  $registerData['restrictive_covenants'][0]['deeds'] = Array.new()
  $registerData['restrictive_covenants'][0]['notes'] = Array.new()
end

def add_bankruptcy()
  $registerData['bankruptcy'] = Array.new()
  $registerData['bankruptcy'][0] = Hash.new()
  $registerData['bankruptcy'][0]['text'] = "A *DT**DE* dated *DD* made between *DP* contains the following provision:-*VT*"
  $registerData['bankruptcy'][0]['full_text'] = "BANKRUPTCY NOTICE entered under section 86(2) of the Land Registration Act 2002 in respect of a pending action, as the title of the proprietor of the registered estate appears to be affected by a petition in bankruptcy against James Lock presented in the Gloucester County Court (Court Reference Number 124578) (Land Charges Reference Number PA102)."
  $registerData['bankruptcy'][0]['fields'] = Hash.new()
  $registerData['bankruptcy'][0]['deeds'] = Array.new()
  $registerData['bankruptcy'][0]['notes'] = Array.new()
end

def add_easement()
  $registerData['easements'] = Array.new()
  $registerData['easements'][0] = Hash.new()
  $registerData['easements'][0]['text'] = "A *DT**DE* dated *DD* made between *DP* contains the following provision:-*VT*"
  $registerData['easements'][0]['full_text'] = "The land tinted pink is subject to the rights granted by a Deed dated 03.03.1976 made between Mr Michael Jones and Mr Jeff Smith. The said Deed also contains restrictive covenants by the grantor. NOTE: Copy filed."
  $registerData['easements'][0]['fields'] = Hash.new()
  $registerData['easements'][0]['deeds'] = Array.new()
  $registerData['easements'][0]['notes'] = Array.new()
end

def add_provision()
  $registerData['provisions'] = Array.new()
  $registerData['provisions'][0] = Hash.new()
  $registerData['provisions'][0]['text'] = "A *DT**DE* dated *DD* made between *DP* contains the following provision:-*VT*"
  $registerData['provisions'][0]['full_text'] = "A Transfer of the land in this title dated 01.06.1996 made between Mr Michael Jones and Mr Jeff Smith contains the following provision:-The land has the benefit of a right of way along the passageway to the rear of the property, and also a right of way on foot only on to the open ground on the north west boundary of the land in this title"
  $registerData['provisions'][0]['fields'] = Hash.new()
  $registerData['provisions'][0]['deeds'] = Array.new()
  $registerData['provisions'][0]['notes'] = Array.new()
end

def add_price_paid()
  $registerData['price_paid'] = Hash.new()
  $registerData['price_paid']['text'] = "The Freehold land shown edged with red on the plan of the above Title filed at the Registry and being *AD*"
  $registerData['price_paid']['full_text'] = "The price stated to have been paid on 15 11 2005 was 100000."
  $registerData['price_paid']['fields'] = Hash.new()
  $registerData['price_paid']['fields']['date'] = dateInThePast().strftime("%d/%m/%Y")
  $registerData['price_paid']['fields']['amount'] = pricePaid()
  $registerData['price_paid']['deeds'] = Array.new()
  $registerData['price_paid']['notes'] = Array.new()
end

def add_proprietors(number)
  $registerData['proprietorship']['fields']['proprietors'] = Array.new()
  for i in 0..number - 1
    $registerData['proprietorship']['fields']['proprietors'][i] = Hash.new()
    $registerData['proprietorship']['fields']['proprietors'][i]['name'] = Hash.new()
    $registerData['proprietorship']['fields']['proprietors'][i]['name']['title'] = "Mrs"
    $registerData['proprietorship']['fields']['proprietors'][i]['name']['full_name'] = fullName()
    $registerData['proprietorship']['fields']['proprietors'][i]['name']['decoration'] = ""
    $registerData['proprietorship']['fields']['proprietors'][i].merge!(generate_address(countryName()))
  end
end

def generate_address(country)
  house_no = houseNumber()
  street_name = roadName()
  town = townName()
  postal_county = 'Greater London'
  region_name = 'Essex'
  country = country
  postcode = postcode()
  $address = Hash.new()
  $address['address'] = Hash.new()
  $address['address']['full_address'] = "#{house_no} #{street_name}, #{town}, #{postal_county}, #{region_name}, #{country}, #{postcode}"
  $address['address']['house_no'] = house_no
  $address['address']['street_name'] = street_name
  $address['address']['town'] = town
  $address['address']['postal_county'] = postal_county
  $address['address']['region_name'] = region_name
  $address['address']['country'] = country
  $address['address']['postcode'] = postcode
  return $address
end
