Feature: login and view private register

Scenario: view register as new authenticated user
Given I have a registered property
And I have private citizen login credentials
And I am not already logged in as a private citizen
When I view the private register
And I login with correct credentials
Then the address of property is displayed
And Title Number is displayed
And Price Paid is displayed
And Tenure is displayed
And Class is displayed
And proprietors are displayed
And Audit for private citizen register view written

Scenario: view register as existing authenticated user
Given I have a registered property
And I am still authenticated
When I view the private register
Then the address of property is displayed
And Title Number is displayed
And Price Paid is displayed
And Tenure is displayed
And Class is displayed
And proprietors are displayed

Scenario: Citizen can only view private register if logged in
Given I have a registered property
And I am not already logged in as a private citizen
When I view the private register
Then I am prompted to login as a private citizen
