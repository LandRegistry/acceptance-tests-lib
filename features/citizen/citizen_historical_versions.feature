Feature: Option to view previous versions of the register

Scenario: As a property owner I can view historical versions of the register

Given I am a citizen
And I am the proprietor of a registered title
And historical versions of the register exist
And I view the full register of title
When I elect to view requests
Then the correct historical versions of the register are displayed
And historical versions of the register are not editable


Scenario: As a non property owner I cannot view historical versions of the register

Given I am a citizen
And a registered title
And historical versions of the register exist
When I view the full register of title
Then a view requests option is not displayed
