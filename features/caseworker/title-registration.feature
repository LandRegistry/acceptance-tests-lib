@casework-frontend
Feature: Create a Title of Register from a received application

Scenario: A new title must contain all mandatory fields before being submitted successfully
Given I have received an application for a first registration
And I want to create a Register of Title
When I submit the title details without entering any data
Then a "This field is required." message for "error_first_name1" is returned
And a "This field is required." message for "error_surname1" is returned
And a "This field is required." message for "error_house_number" is returned
And a "This field is required." message for "error_road" is returned
And a "This field is required." message for "error_town" is returned
And a "This field is required." message for "error_postcode" is returned
And a "Not a valid choice" message for "error_property_tenure" is returned
And a "Not a valid choice" message for "error_property_class" is returned
And a "This field is required." message for "error_extent" is returned

Scenario: Optional fields must be validated when incorrect data entered
Given I have received an application for a first registration
And I want to create a Register of Title
And I enter a price paid with too many decimal places
And I add a charge with no information
When I submit the title details
Then a "Please enter the price paid as pound and pence" message for "error_price_paid" is returned
Then a "This field is required." message for "error_charges-0-charge_date" is returned
Then a "This field is required." message for "error_charges-0-chargee_name" is returned
Then a "This field is required." message for "error_charges-0-chargee_registration_number" is returned
Then a "This field is required." message for "error_charges-0-chargee_address" is returned


Scenario: Caseworker can create a Register of Title with only mandatory fields filled in
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Freehold
And I select class of Possessory
And I enter 1 proprietor
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered

Scenario: Caseworker can create a Register of Title with all fields filled in - including multiple charges
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Freehold
And I select class of Possessory
And I enter a valid price paid
And I enter 2 company charges
And I enter 2 proprietors
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered

Scenario: A new title where lease is expanded prompts for required fields
Given I have received an application for a first registration
And I want to create a Register of Title
And I choose a tenure of Leasehold
When I submit the title details
Then a "This field is required." message for "error_first_name1" is returned
And a "This field is required." message for "error_surname1" is returned
And a "This field is required." message for "error_house_number" is returned
And a "This field is required." message for "error_road" is returned
And a "This field is required." message for "error_town" is returned
And a "This field is required." message for "error_postcode" is returned
And a "Not a valid choice" message for "error_property_class" is returned
And a "This field is required." message for "error_extent" is returned
And a "This field is required." message for "error_date_of_lease" is returned
And a "This field is required." message for "error_term" is returned
And a "This field is required." message for "error_term_start_date" is returned
And a "This field is required." message for "error_lessor_name" is returned
And a "This field is required." message for "error_lessee_name" is returned
