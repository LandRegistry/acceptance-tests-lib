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
And I enter a Country of marriage
And I enter a location of marriage
And I enter a Marriage Certificate Number
Then I am presented with my information in the certify message

Scenario: Change of name Confirmation Message (marriage)
Given I have have got married and I want to change my name on the register
And I have a registered property
And I have private citizen login credentials
And I want to request I change my name on the register
And I am logged in
When I enter a new name
And I enter my date of marriage
And I enter my partners name
And I enter a Country of marriage
And I enter a location of marriage
And I enter a Marriage Certificate Number
And I submit the marriage change of name details
Then I receive a confirmation that my change of name request has been lodged

Scenario: Change of name Missing fields (marriage)
Given I have a registered property
And I have private citizen login credentials
And I want to request I change my name on the register
And I am logged in
When I submit the marriage change of name details
Then a "This field is required." message for "error_proprietor_new_name" is returned
And a "This field is required." message for "error_partner_full_name" is returned
And a "This field is required." message for "error_date_of_marriage" is returned
And a "This field is required." message for "error_location_of_marriage_ceremony" is returned
And a "This field is required." message for "error_marriage_certificate_number" is returned
