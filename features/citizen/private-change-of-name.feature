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
And I enter a witness name
And I enter a Witness Address
And I submit the marriage change of name details
Then I am presented with a statement I need to accept

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
And I enter a witness name
And I enter a Witness Address
And I submit the marriage change of name details
And I Accept the statement
Then I receive a confirmation that my change of name request has been lodged

Scenario: Change of name Missing fields (marriage)
Given I have a registered property
And I have private citizen login credentials
And I want to request I change my name on the register
And I am logged in
When I submit the marriage change of name details
Then a "This field is required." message for "(name error id tag here)" is returned
And a "This field is required." message for "(partners name marriage error id tag here)" is returned
And a "This field is required." message for "(date of marriage error id tag here)" is returned
And a "This field is required." message for "(country error id tag here)" is returned
And a "This field is required." message for "(location error id tag here)" is returned
And a "This field is required." message for "(marriage certificate error id tag here)" is returned
And a "This field is required." message for "(witness name error id tag here)" is returned
And a "This field is required." message for "(witness address error id tag here)" is returned
