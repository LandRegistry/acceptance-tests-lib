def generate_relationship_token_information()
  $relationshipData['citizen_relationship'] = Array.new()
  $relationshipData = Hash.new()
  $relationshipData['title_number'] = titleNumber()
  $relationshipData['transaction'] = titleNumber()


Full name
Date of birth
Address
Telephone
Email address
Title number
buying/ selling

$regData = Hash.new()
$regData['title_number'] = titleNumber()

$regData['proprietors'] = Array.new()

$regData['proprietors'][0] = Hash.new()
$regData['proprietors'][0]['full_name'] = fullName()

$regData['proprietors'][1] = Hash.new()

  if (!$data_characteristics['has a charge'].nil?)

    $regData['charges'] = Array.new()
    $regData['charges'][0] = Hash.new()
    $regData['charges'][0]['charge_date'] = '2014-08-11'
    $regData['charges'][0]['chargee_address'] = '12 Test Street, London, SE1 33S'
    $regData['charges'][0]['chargee_name'] = 'Test Bank'
    $regData['charges'][0]['chargee_registration_number'] = '1234567'

    if (!$data_characteristics['has no charge restriction'].nil?)
      $regData['charges'][0]['charges-0-has_restriction'] = false
    else
      $regData['charges'][0]['charges-0-has_restriction'] = true
    end

  end

end

Given(/^am acting on behalf of (\d+) buyers$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I select the property$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter my clients details$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^a relationship token code is generated$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I have a relationship token for a registered property$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^others are yet to complete conveyancer authorisation$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I want to authorise my conveyancer to act on my behalf to buy the property$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter the relationship token code$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the relationship details are correctly presented$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^the relationship is confirmed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^relationship confirmed but not completed$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^others have completed the conveyancer authorisation$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I want to authorise my conveyancer to act on my behalf to sell the property$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^relationship confirmed and shown as completed$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid relationship token code$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^message informing relationship token code is invalid$/) do
  pending # express the regexp above with the code you wish you had
end
