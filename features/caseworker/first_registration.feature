@casework-frontend
Feature: Create a First Register from a received application

@performance_test_script
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

Scenario: Processing Good Leasehold First Registration with 1 proprietor and all valid details but no clauses and lessee as a proprietor
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Leasehold
And I enter valid Date of Lease
And I enter valid Term Years
And I enter valid term start date
And I enter Lessor name
And I enter proprietor as lessee name
And I select class of Good
And I enter a valid price paid
And I enter 1 proprietor
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered

Scenario: Processing Absolute Leasehold First Registration with 2 proprietors and all valid details with clauses and different lessee
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Leasehold
And I enter valid Date of Lease
And I enter valid Term Years
And I enter valid term start date
And I enter Lessor name
And I enter non proprietor lessee name
And I select easement within lease
And I select alienation
And I select landlords title registered
And I select class of Absolute
And I enter a valid price paid
And I enter 2 proprietors
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
And Title Number is formatted correctly

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
Then a "This field is required." message for "error_full_name1" is returned
And a "This field is required." message for "error_address_line_1" is returned
And a "This field is required." message for "error_city" is returned
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

Scenario: A new title where lease is expanded prompts for required fields
Given I have received an application for a first registration
And I want to create a Register of Title
And I choose a tenure of Leasehold
When I submit the title details
Then a "Not a valid choice" message for "error_property_class" is returned
And a "This field is required." message for "error_extent" is returned
And a "This field is required." message for "error_leases-0-lease_date" is returned
And a "This field is required." message for "error_leases-0-lease_term" is returned
And a "This field is required." message for "error_leases-0-lease_from" is returned
And a "This field is required." message for "error_leases-0-lessor_name" is returned
And a "This field is required." message for "error_leases-0-lessee_name" is returned
