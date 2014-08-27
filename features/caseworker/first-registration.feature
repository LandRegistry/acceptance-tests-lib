@casework-frontend
Feature: Create a Register from a received application

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

Scenario: Processing Good Leasehold First Registration with 1 proprietor and all valid details but no clauses and lessor as a proprietor
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Leasehold
And I enter valid Date of Lease
And I enter valid Term Years
And I enter valid term start date
And I enter proprietor as lessor name
And I enter Lessee name
And I select class of Good
And I enter a valid price paid
And I enter 1 proprietor
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered

Scenario: Processing Absolute Leasehold First Registration with 2 proprietors and all valid details with clauses and different lessor
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Leasehold
And I enter valid Date of Lease
And I enter valid Term Years
And I enter valid term start date
And I enter non proprietor lessor name
And I enter Lessee name
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
