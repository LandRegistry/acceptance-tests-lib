Feature: login and view private register

Scenario: view register as new authenticated user
Given I have a registered Freehold property
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
And the company charge is displayed
And Audit for private citizen register view written

Scenario: view freehold register as existing authenticated user
Given I have a registered Freehold property
And I am still authenticated
When I view the private register
Then the address of property is displayed
And Title Number is displayed
And Price Paid is displayed
And Tenure is displayed
And Class is displayed
And proprietors are displayed
And the company charge is displayed

Scenario: view lease register as new authenticated user without clauses and different lessee
Given I have registered Leasehold property data
And There are no lease clauses
And Lessee name is different as proprietor
And I submit the registered property data
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
And the company charge is displayed
And Date of Lease is displayed
And Lease Term is displayed
And Lease Term start date is displayed
And Lessor name is displayed
And Lessee name is displayed
And easements within the lease clause NOT displayed
And alienation clause NOT displayed
And landlords title registered clause NOT displayed
And Audit for private citizen register view written

Scenario: view lease register as new authenticated user with clauses and lessee as proprietor
Given I have registered Leasehold property data
And All the lease clauses exist
And Lessee name is different as proprietor
And I submit the registered property data
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
And the company charge is displayed
And Date of Lease is displayed
And Lease Term is displayed
And Lease Term start date is displayed
And Lessor name is displayed
And Lessee name is displayed
And easements within the lease clause is displayed
And alienation clause is displayed
And landlords title registered clause is displayed
And Audit for private citizen register view written

Scenario: Citizen can only view private register if logged in
Given I have a registered Freehold property
And I am not already logged in as a private citizen
When I view the private register
Then I am prompted to login as a private citizen

Scenario: Private Register with Title Plan Single Polygon with easement
Given I have a registered property with an easement
And I have private citizen login credentials
And I am not already logged in as a private citizen
When I view the private register
And I login with correct credentials
And I check the title plan (private view)
Then there is 1 polygon
And the whole polygon area is in view
And the polygon matches that of the title
And the polygon is edged in red
And the polygon has an easement
And the map can't be zoomed
And the map can't be moved
And the Polygon is laid over a map

Scenario: Private Register with Title Plan Two Polygons
Given I have a registered property with multiple polygons
And I have private citizen login credentials
And I am not already logged in as a private citizen
When I view the private register
And I login with correct credentials
And I check the title plan (private view)
Then there is 2 polygons
And the whole polygon area is in view
And the polygons matches that of the title
And the polygons are edged in red
And the map can't be zoomed
And the map can't be moved
And the Polygons are laid over a map
