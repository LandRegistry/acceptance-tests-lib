@property-frontend
Feature: View property details on gov.uk

Scenario: view freehold register as citizen

  Given I am a citizen
  And a registered title
  When I view the property details on gov.uk
  Then the Property Address is displayed
  And Title Number is displayed
  And Price Paid is displayed
  And No lease information is displayed

Scenario: view lease register as citizen without clauses and different lessee

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS                               |
    | leasehold                                     |
    | has no lease clauses                          |
    | has a lessee name different to the proprietor |
  When I view the property details on gov.uk
  Then the Property Address is displayed
  And Title Number is displayed
  And Price Paid is displayed
  And Date of Lease is displayed
  And Lease Term is displayed
  And Lease Term start date is displayed
  And Lessor name is displayed
  And Lessee name is displayed
  And the lease clauses are not displayed

Scenario: view lease register as citizen with clauses and lessee as proprietor
  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS                            |
    | leasehold                                  |
    | has lease clauses                          |
    | has a lessee name matching the proprietor  |
  When I view the property details on gov.uk
  Then the Property Address is displayed
  And Title Number is displayed
  And Price Paid is displayed
  And Date of Lease is displayed
  And Lease Term is displayed
  And Lease Term start date is displayed
  And Lessor name is displayed
  And Lessee name is not displayed
  And the lease clauses are displayed

Scenario: try to view register that does not exist

  Given I am a citizen
  When I try to view a property that does not exist
  Then an error is displayed

Scenario: Public Register with Title Extents

  Given I am a citizen
  And a registered title with characteristics
      | CHARACTERISTICS                   |
      | has a polygon with easement       |
      | has a doughnut polygon            |
  When I view the property details on gov.uk
  And I check the title plan (public view)
  Then there is 2 polygons
  And the whole polygon area is in view
  And the polygons matches that of the title
  And the polygons are edged in red
  And there is a donut polygon
  And there is a normal polygon
  And there are no easements displayed
  And the map can't be zoomed
  And the map can't be moved
  And the Polygons are laid over a map
