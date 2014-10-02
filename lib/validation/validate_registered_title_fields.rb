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
  assert_match(/#{$regData['property_description']['fields']['address']['full_address']}/i, page.body, 'Expected to find full address')
end

def checkProprietors()
  assert_match(/#{$regData['proprietorship']['fields']['proprietors'][0]['name']['full_name']}/i, page.body, 'Expected to see proprietor name')
end

def checkRestrictiveCovenants()

end

def checkBankruptcyNotice()

end

def checkEasement()

end

def checkProvision()
  assert_match(/#{$regData['provisions'][0]['full_text']}/i, page.body, 'Expected to see proprietor name')
end

def checkRegisterDetails()
  checkTitleNumber()
  checkPricePaid()
  checkTenure()
  checkClassOfTitle()
  checkPropertyAddress()
  checkProprietors()
end

#charges
def checkCompanyCharge()
  assert_match(Date.parse($regData['charges'][0]['charge_date']).strftime("%d %B %Y"), page.body, 'Expected to find house_number')
  assert_match(/#{$regData['charges'][0]['chargee_address']}/i, page.body, 'Expected to find chargee_address')
  assert_match(/#{$regData['charges'][0]['chargee_name']}/i, page.body, 'Expected to find chargee_name')
  assert_match(/#{$regData['charges'][0]['chargee_registration_number']}/i, page.body, 'Expected to find chargee_registration_number')
end

def checkCompanyChargeWithARestriction()
  checkCompanyCharge()
  restriction_text = "No disposition of the registered estate by the proprietor of the registered estate is to be registered without a written consent signed by the proprietor for the time being of the Charge dated "
  restriction_text = restriction_text + Date.parse($regData['charges'][0]['charge_date']).strftime("%d %B %Y")
  restriction_text = restriction_text +  " in favour of "
  restriction_text = restriction_text +  $regData['charges'][0]['chargee_name']
  restriction_text = restriction_text + " referred to in the Charges Register."
  assert_match(/#{restriction_text}/, page.body.gsub(/\s+/, ' '), 'expected to find charge restriction '+restriction_text)
end

def checkCompanyChargeWithNoRestriction()
  checkCompanyCharge()
  restriction_text = "No disposition of the registered estate by the proprietor of the registered estate is to be registered without a written consent signed by the proprietor for the time being of the Charge dated "
  assert_no_match(/#{restriction_text}/, page.body, 'charge restriction not expected ')
end

#leases
def checkDateOfLease()
  lease_date_formatted = Date.parse($regData['leases'][0]['lease_date'])
  lease_date_formatted = lease_date_formatted.strftime("%d %B %Y")
  assert_selector(".//*[@id='leaseDate']", text: lease_date_formatted)
end

def checkLeaseTerm()
  assert_selector(".//*[@id='leaseTerm']", text: /#{$regData['leases'][0]['lease_term']} years/)
end

def checkLeaseTermStartDate()
  lease_term_start_date_formatted = Date.parse($regData['leases'][0]['lease_from'])
  lease_term_start_date_formatted = lease_term_start_date_formatted.strftime("%d %B %Y")
  assert_selector(".//*[@id='leaseTerm']", text: /from #{lease_term_start_date_formatted}/)
end

def checkLessorName()
  assert_selector(".//*[@id='parties']", text: /1. #{$regData['leases'][0]['lessor_name']}/)
end

def checkLesseeName()
  assert_selector(".//*[@id='parties']", text: /2. #{$regData['leases'][0]['lessee_name']}/)
end

def checkNotExistLesseeName()
  assert_no_selector(".//*[@id='parties']", text: /2. #{$regData['leases'][0]['lessee_name']}/)
end

def checkLeaseClauses()
  assert_selector(".//*[@id='easementClause']")
  assert_selector(".//*[@id='easementClause']")
  assert_selector(".//*[@id='alienationClause']")
end

def checkNotExistLeaseClauses()
  assert_no_selector(".//*[@id='easementClause']")
  assert_no_selector(".//*[@id='easementClause']")
  assert_no_selector(".//*[@id='alienationClause']")
end
