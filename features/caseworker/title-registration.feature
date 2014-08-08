@casework-frontend
Feature: Create a Register from a received application

Scenario Outline: A new title must contain all mandatory fields before being submitted successfully
Given I have received an application for a first registration
And I want to create a Register of Title
When I submit the title details without entering any data
Then a <errorMessage> for <fieldId> is returned

Examples:
| fieldId               | errorMessage            |
| error_first_name1     | This field is required. |
| error_surname1        | This field is required. |
| error_house_number    | This field is required. |
| error_road            | This field is required. |
| error_town            | This field is required. |
| error_postcode        | This field is required. |
| error_property_tenure | Not a valid choice      |
| error_property_class  | Not a valid choice      |
| error_extent          | This field is required. |

Scenario: Caseworker can submit a form with all fields filled in - including a charge
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

Scenario: Caseworker can submit a form with 2 proprietors and multiple charges
Given I have received an application for a first registration
And I want to create a Register of Title
When I enter a Property Address
And I choose a tenure of Freehold
And I select class of Possessory
And I enter a valid price paid
And I enter 2 company charge
And I enter 2 proprietor
And I enter a valid title extent
And I submit the title details
Then I have received confirmation that the property has been registered
