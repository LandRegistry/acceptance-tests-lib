#required fields
def checkTitleNumber()
  puts $regData['title_number']
  assert_match(/#{$regData['title_number']}/i, page.body, 'Expected to see title number')
end

def checkPricePaid()
  #assert_match(/#{$regData['price_paid']['fields']['amount'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}/i, page.body, 'Expected to see price paid')
  assert_match(/#{$regData['price_paid']['fields']['amount']}/i, page.body, 'Expected to see price paid')

end

def checkTenure()
  assert_match(/#{$regData['property_description']['fields']['tenure']}/i, page.body, 'Expected to see tenure value')
end

def checkClassOfTitle()
  #assert_match(/#{$regData['property']['class_of_title']}/i, page.body, 'Expected to see class of title value')
end

def checkPropertyAddress()
    assert_match(/#{$regData['property_description']['fields']['address']['full_address']}/i, page.body, 'Expected to see full address')
end

def checkStructuredPropertyAddress()
    #assert_match(/#{$regData['property_description']['fields']['address']['house_no']}/i, page.body, 'Expected to see full address')
    assert_match(/#{$regData['property_description']['fields']['address']['street_name']}/i, page.body, 'Expected to see full address')
    assert_match(/#{$regData['property_description']['fields']['address']['town']}/i, page.body, 'Expected to see full address')
    assert_match(/#{$regData['property_description']['fields']['address']['postal_county']}/i, page.body, 'Expected to see full address')
    assert_match(/#{$regData['property_description']['fields']['address']['region_name']}/i, page.body, 'Expected to see full address')
    #assert_match(/#{$regData['property_description']['fields']['address']['country']}/i, page.body, 'Expected to see full address')
    #assert_match(/#{$regData['property_description']['fields']['address']['postcode']}/i, page.body, 'Expected to see full address')
end

def checkProprietors()
  assert_match(/#{$regData['proprietorship']['fields']['proprietors'][0]['name']['full_name']}/i, page.body, 'Expected to see proprietor name')
end

def checkRestrictiveCovenants()

end

def checkRestriction()

end

def checkBankruptcyNotice()

end

def checkEasement()

end

def checkProvision()
  assert_match(/#{$regData['provisions'][0]['full_text']}/i, page.body, 'Expected to see provision full text')
end

def checkRegisterDetails()
  checkTitleNumber()
  checkPricePaid()
  checkTenure()
  checkClassOfTitle()
  checkPropertyAddress()
  checkProprietors()
end
