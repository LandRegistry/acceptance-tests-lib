Feature: Create relationship between acting conveyancer and a citizen buyer(s) or seller(s)

Scenario: Create relationship token for buyers
Given I have conveyancer login credentials
And I am not already logged in as a conveyancer
And clients have provided their details for me to act on their behalf
And a registered title
When I request to create a client relationship
And I login with correct credentials
And I select the property
And the clients want to buy the property
And I enter the clients details
And I confirm the details entered
Then a relationship token code is generated

@wip
Scenario: First citizen of a couple authorises the conveyancer client relationship
Given I have private citizen login credentials
And I am not already logged in as a private citizen
And I want to buy the property
And others are yet to complete conveyancer authorisation
And I have a relationship token for a registered property
When I want to authorise my conveyancer to act on my behalf
And I login with correct credentials
And I enter the relationship token code
Then the relationship details are correctly presented
When I have ticked that the information I have read is correct
And the relationship is confirmed
Then the relationship is confirmed but not completed

@wip
Scenario: Last citizen of couple authorises conveyancer client relationship
Given I have private citizen login credentials
And I am not already logged in as a private citizen
And I want to sell the property
And others have completed the conveyancer authorisation
And I want to authorise my conveyancer to act on my behalf
And I have a relationship token for a registered property
When I login with correct credentials
And I enter the relationship token code
Then the relationship details are correctly presented
When I have ticked that the information I have read is correct
And the relationship is confirmed
Then relationship confirmed and shown as completed

@wip
Scenario: Citizen enters invalid relationship token
Given I have private citizen login credentials
And I am not already logged in as a private citizen
When I login with correct credentials
And I enter an invalid relationship token code
Then message informing relationship token code is invalid is displayed
