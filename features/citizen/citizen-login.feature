Feature: Citizen login

Scenario: Invalid username login failed
Given I have private citizen login credentials
And I am not already logged in as a private citizen
And I login with incorrect username
Then I fail to login (incorrect username)

Scenario: Invalid password login failed
Given I have private citizen login credentials
And I am not already logged in as a private citizen
When I login with incorrect password
Then I fail to login (incorrect password)

Scenario: Citizen can logout
Given I have private citizen login credentials
And I am still authenticated
When I logout as a private citizen
Then I am prompted to login as a private citizen
