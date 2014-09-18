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

Scenario: Citizen authorises the conveyancer client relationship
Given I have private citizen login credentials
And I am not already logged in as a private citizen
And I have a relationship token for a registered property
When I want to authorise my conveyancer to act on my behalf
And I enter the relationship token code
And I have ticked that the information I have read is correct
Then the relationship is confirmed

Scenario: Citizen enters invalid relationship token
Given I have private citizen login credentials
And I am not already logged in as a private citizen
When I want to authorise my conveyancer to act on my behalf
And I enter an invalid relationship token code
Then message informing relationship token code is invalid is displayed
