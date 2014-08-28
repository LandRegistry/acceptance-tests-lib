@property-frontend
Feature: Citizen view register

Scenario: view freehold register as citizen
Given I have a registered Freehold property
And I am a citizen
When I view the register
Then the address of property is displayed
And Title Number is displayed
And Price Paid is displayed
And No lease information is displayed
And Audit for public citizen search of title written

Scenario: view lease register as citizen without clauses and different lessee
Given I have a registered Leasehold property
And easements within the lease clause NOT existing
And alienation clause NOT existing
And landlords title registered clause NOT existing
And Lessee name is different as proprietor
And I am a citizen
When I view the register
Then the address of property is displayed
And Title Number is displayed
And Price Paid is displayed
And Date of Lease is displayed
And Lease Term is displayed
And Lease Term start date is displayed
And Lessor name is displayed
And Lessee name is displayed
And easements within the lease clause NOT displayed
And alienation clause NOT displayed
And landlords title registered clause NOT displayed
And Audit for public citizen search of title written

Scenario: view lease register as citizen with clauses and lessee as proprietor
Given I have a registered Leasehold property
And easements within the lease clause is existing
And alienation clause is existing
And landlords title registered clause is existing
And Lessee name is same as proprietor
And I am a citizen
When I view the register
Then the address of property is displayed
And Title Number is displayed
And Price Paid is displayed
And Date of Lease is displayed
And Lease Term is displayed
And Lease Term start date is displayed
And Lessor name is displayed
And Lessee name NOT displayed
And easements within the lease clause is displayed
And alienation clause is displayed
And landlords title registered clause is displayed
And Audit for public citizen search of title written

Scenario: try to view register that does not exist
Given I am a citizen
When I try to view a register that does not exist
Then an error will be displayed

Scenario: Register with Title Plan Single Polygon
Given I have a registered Freehold property
And I am a citizen
When I view the register
And I check the title plan
Then there is 1 polygon
And the whole polygon area is in view
And the polygon matches that of the title
And the polygon is edged in red
And the map can't be zoomed
And the map can't be moved
And the Polygon is laid over a map

@wip
Scenario: Register with Title Plan Two Polygons
Given I have a registered property with multiple polygons
And I am a citizen
When I view the register
And I check the title plan
Then there is 2 polygons
And the whole polygon area is in view
And the polygons matches that of the title
And the polygons are edged in red
And the map can't be zoomed
And the map can't be moved
And the Polygons are laid over a map

Scenario: Register with Title Plan Donut Polygons
Given I have a registered property with donut polygons
And I am a citizen
When I view the register
And I check the title plan
Then there is 1 polygons
And the polygon is a donut
And the whole polygon area is in view
And the polygons matches that of the title
And the polygons are edged in red
And the map can't be zoomed
And the map can't be moved
And the Polygons are laid over a map
