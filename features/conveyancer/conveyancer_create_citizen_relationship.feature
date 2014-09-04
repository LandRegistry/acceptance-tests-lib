Scenario: Create relationship token for buyers
Given I have Conveyancer login credentials
And I have a registered property
And am acting on behalf of 2 buyers
And I am logged in
When I select the property
And I enter my clients details
Then a relationship token code is generated

Scenario: first citizen of couple creates authorises conveyancer buyer relationship
Given I have private citizen login credentials
And I have a relationship token for a registered property
And I am the first of 2 buyers to authorise conveyancer
And I am logged in
When I enter the relationship token code
Then the relationship details are correctly presented
When the relationship is confirmed
Then relationship confirmed but not completed

Scenario: last citizen of couple creates authorises conveyancer seller relationship
Given I have private citizen login credentials
And I have a relationship token for a registered property
And I am the last of 2 sellers to authorise conveyancer
And I am logged in
When I enter the relationship token code
Then the relationship details are correctly presented
When the relationship is confirmed
Then relationship confirmed and shown as completed

Scenario: citizen enters invalid relationship token
Given I have private citizen login credentials
And I am logged in
When I enter an invalid relationship token code
Then message informing relationship token code is invalid
