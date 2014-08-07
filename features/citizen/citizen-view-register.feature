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

Scenario: Register with Title Plan
Given I have a registered property
And I am a citizen
When I view the register
And I check the title plan
Then there is at least one polygon
And the whole polygon is in view
And the polygon matches that of the title
And the polygon is edged in red
And the map can't be zoomed
And the map can't be moved
And the Polygon is laid over a map
