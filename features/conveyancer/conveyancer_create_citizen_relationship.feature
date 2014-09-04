Feature: create relationship between acting conveyancer and citizen buyer and sellers

Scenario: Create relationship token for buyers
Given I have conveyancer login credentials
And I am not already logged in as a conveyancer
And I have a registered property
And am acting on behalf of 2 buyers
When I login with correct credentials
And I select the property
And I enter my clients details
Then a relationship token code is generated

Scenario: first citizen of couple creates authorises conveyancer buyer relationship
Given I have private citizen login credentials
And I am not already logged in as a private citizen
And I have a relationship token for a registered property
And others are yet to complete conveyancer authorisation
And I want to authorise my conveyancer to act on my behalf to buy the property
When I login with correct credentials
And I enter the relationship token code
Then the relationship details are correctly presented
When the relationship is confirmed
Then relationship confirmed but not completed

Scenario: last citizen of couple creates authorises conveyancer seller relationship
Given I have private citizen login credentials
And I am not already logged in as a private citizen
And I have a relationship token for a registered property
And others have completed the conveyancer authorisation
And I want to authorise my conveyancer to act on my behalf to sell the property
When I login with correct credentials
And I enter the relationship token code
Then the relationship details are correctly presented
When the relationship is confirmed
Then relationship confirmed and shown as completed

Scenario: citizen enters invalid relationship token
Given I have private citizen login credentials
And I am not already logged in as a private citizen
When I login with correct credentials
And I enter an invalid relationship token code
Then message informing relationship token code is invalid
