@property-frontend @geoff
Feature: Citizen view register

Scenario: view register as citizen
Given I have a registered property
And I am a citizen
When I view the register
Then the address of property is displayed
And Title Number is displayed
And Price Paid is displayed
And the Title Extent is displayed
And Audit for public citizen search of title written

Scenario: try to view register that does not exist
Given I am a citizen
When I try to view a register that does not exist
Then an error will be displayed

Scenario: Register with Title Plan Single Polygon
Given I have a registered property
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

Scenario: Register with Title Plan Two Polygons
Given I have a registered property with 2 polygons
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






Scenario: Register with Title Plan
Given I am testing
