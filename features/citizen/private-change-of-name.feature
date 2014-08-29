Feature: Change of Name (marriage)

Scenario: Change of name Statement (marriage)
Given I have have got married and I want to change my name on the register
And I have a registered property
And I have private citizen login credentials
And I want to request I change my name on the register
And I am logged in
When I enter a new name
And I enter my date of marriage
And I enter my partners name
And I enter "GB" as the country of marriage
And I enter a location of marriage
And I enter a Marriage Certificate Number
And I submit the marriage change of name details
Then I am presented to certify my details

Scenario: Change of name Confirmation Message (marriage)
Given I have have got married and I want to change my name on the register
And I have a registered property
And I have private citizen login credentials
And I want to request I change my name on the register
And I am logged in
When I enter a new name
And I enter my date of marriage
And I enter my partners name
And I enter "GB" as the country of marriage
And I enter a location of marriage
And I enter a Marriage Certificate Number
And I submit the marriage change of name details
And I accept the certify statement
Then I receive a confirmation that my change of name request has been lodged

Scenario: Change of name Missing fields (marriage)
Given I have a registered property
And I have private citizen login credentials
And I want to request I change my name on the register
And I am logged in
When I submit the marriage change of name details
Then a "This field is required." message for "error_proprietor_new_full_name" is returned
And a "This field is required." message for "error_partner_name" is returned
And a "This field is required." message for "error_marriage_date" is returned
And a "This field is required." message for "error_marriage_place" is returned
And a "This field is required." message for "error_marriage_country" is returned
And a "This field is required." message for "error_marriage_certificate_number" is returned
