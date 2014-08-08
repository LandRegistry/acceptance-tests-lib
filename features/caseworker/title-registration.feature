@casework-frontend
Feature: Create a Title of Register from a received application

Scenario Outline: A new title must contain all mandatory fields before being submitted successfully
Given I have received an application for a first registration
And I want to create a Register of Title
When I submit the title details without entering any data
Then a <errorMessage> for <fieldId> is returned

Examples:
  | errorMessage            | fieldId               |
  | This field is required. | error_first_name1     |
  | This field is required. | error_surname1        |
  | This field is required. | error_house_number    |
  | This field is required. | error_road            |
  | This field is required. | error_town            |
  | This field is required. | error_postcode        |
  | Not a valid choice      | error_property_tenure |
  | Not a valid choice      | error_property_class  |
  | This field is required. | error_extent          |

Scenario: Optional fields must be validated when data entered
Given I have received an application for a first registration
And I want to create a Register of Title
And I enter a price paid with too many decimal places
When I submit the title details
Then a "Please enter the price paid as pound and pence" for "error_price_paid" is returned

Scenario: Caseworker can create a Register of Title with all fields filled in - including a company charge
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Freehold
And I select class of Possessory
And I enter a valid price paid
And I enter 1 company charge
And I enter 1 proprietor
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered

Scenario: Caseworker can create a Register of Title with multiple proprietors and company charges
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
