Feature: login and view private register

Scenario: view register as new authenticated user
Given I have a registered propertyB
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

Scenario: view freehold register as existing authenticated user with charge but no restriction
Given I have a registered property with characteristicsB
  | CHARACTERISTICS           |
  | two proprietors           |
  | has a charge              |
  | has no charge restriction |
And I am still authenticated
When I view the private register
Then the address of property is displayed
And Title Number is displayed
And Price Paid is displayed
And Tenure is displayed
And Class is displayed
And proprietors are displayed
And the company charge is displayed with no restriction

Scenario: view freehold register as existing authenticated user with charge and a restriction
Given I have a registered property with characteristicsB
  | CHARACTERISTICS            |
  | has a charge               |
  | has a charge restriction   |
And I am still authenticated
When I view the private register
Then the address of property is displayed
And Title Number is displayed
And Price Paid is displayed
And Tenure is displayed
And Class is displayed
And proprietors are displayed
And the company charge is displayed
And the company charge is displayed with a restriction

Scenario: view lease register as new authenticated user without clauses and different lessee
Given I have a registered property with characteristicsB
  | CHARACTERISTICS                               |
  | leasehold                                     |
  | has no lease clauses                          |
  | has a lessee name different to the proprietor |
And I have private citizen login credentials
And I am not already logged in as a private citizen
When I view the private register
And I login with correct credentials
Then Date of Lease is displayed
And Lease Term is displayed
And Lease Term start date is displayed
And Lessor name is displayed
And Lessee name is displayed
And easements within the lease clause NOT displayed
And alienation clause NOT displayed
And landlords title registered clause NOT displayed
And Audit for private citizen register view written

Scenario: view lease register as new authenticated user with clauses and lessee as proprietor
Given I have a registered property with characteristicsB
  | CHARACTERISTICS                            |
  | leasehold                                  |
  | has lease clauses                          |
  | has a lessee name matching the proprietor  |
And I have private citizen login credentials
And I am not already logged in as a private citizen
When I view the private register
And I login with correct credentials
Then Date of Lease is displayed
And Lease Term is displayed
And Lease Term start date is displayed
And Lessor name is displayed
And Lessee name is displayed
And easements within the lease clause is displayed
And alienation clause is displayed
And landlords title registered clause is displayed
And Audit for private citizen register view written

Scenario: Citizen can only view private register if logged in
Given I have a registered propertyB
And I am not already logged in as a private citizen
When I view the private register
Then I am prompted to login as a private citizen

Scenario: Private Register with Title Extents
Given I have a registered property with characteristicsB
  | CHARACTERISTICS                   |
  | has a polygon with easement       |
  | has a doughnut polygon            |
And I have private citizen login credentials
And I am not already logged in as a private citizen
When I view the private register
And I login with correct credentials
And I check the title plan (private view)
Then there is 2 polygons
And the whole polygon area is in view
And the polygons matches that of the title
And the polygons are edged in red
And there is a donut polygon
And there is a normal polygon
And there is an easement
And the map can't be zoomed
And the map can't be moved
And the Polygons are laid over a map
