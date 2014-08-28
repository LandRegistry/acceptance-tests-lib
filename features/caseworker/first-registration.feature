@casework-frontend
Feature: Create a First Register from a received application

Scenario: Processing Absolute Freehold First Registration with 1 proprietor (3)
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Freehold
And I select class of Absolute
And I enter a valid price paid
And I enter 1 proprietor
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered
And Audit for new registration is written

Scenario: Processing Good Leasehold First Registration with 1 proprietor (4)
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Leasehold
And I select class of Good
And I enter a valid price paid
And I enter 1 proprietor
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered

Scenario: Processing possessory Freehold First Registration with 2 proprietors (5)
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Freehold
And I select class of Possessory
And I enter a valid price paid
And I enter 2 proprietors
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered

Scenario: Processing Qualified Freehold First Registration with 1 proprietor and no price paid (6)
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Freehold
And I select class of Qualified
And I enter 1 proprietor
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered

Scenario: Trying to process a first registration with no proprietor (2)
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Freehold
And I select class of Absolute
And I enter a valid title extent
And I submit the title details
Then the user will be prompted again for a proprietor

Scenario: Trying to process a first registration with no address (8)
Given I have received an application for a first registration
And I want to create a Register of Title
When I choose a tenure of Freehold
And I select class of Absolute
And I enter a valid price paid
And I enter 1 proprietor
And I enter a valid title extent
And I submit the title details
Then the user will be prompted again for required address fields

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

Scenario: Caseworker can create a Register of Title with all fields filled in
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Freehold
And I select class of Possessory
And I enter a valid price paid
And I enter 2 company charges
And I enter 2 proprietors
And I enter a valid title extent
And I enter a valid title easement
And I submit the title details
Then I have received confirmation that the property has been registered
