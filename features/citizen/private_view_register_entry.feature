Feature: login and view private register

Scenario: view register as new authenticated user

  Given I am a citizena
  And a registered title
  When I view the full register of title
  Then the Property Address is displayed
  And Title Number is displayed
  And Price Paid is displayed
  And Tenure is displayed
  And Class of Title is displayed
  And proprietors are displayed
  And Audit for private citizen register view written

Scenario: view freehold register as existing authenticated user with charge but no restriction

  Given I am a citizena
  And a registered title with characteristics
    | CHARACTERISTICS           |
    | two proprietors           |
    | has a charge              |
    | has no charge restriction |
  When I view the full register of title
  Then the Property Address is displayed
  And Title Number is displayed
  And Price Paid is displayed
  And Tenure is displayed
  And Class of Title is displayed
  And proprietors are displayed
  And the company charge is displayed with no restriction

Scenario: view freehold register as existing authenticated user with charge and a restriction

  Given I am a citizena
  And a registered title with characteristics
    | CHARACTERISTICS            |
    | has a charge               |
    | has a charge restriction   |
  When I view the full register of title
  Then the Property Address is displayed
  And Title Number is displayed
  And Price Paid is displayed
  And Tenure is displayed
  And Class of Title is displayed
  And proprietors are displayed
  And the company charge is displayed
  And the company charge is displayed with a restriction

Scenario: view lease register as new authenticated user without clauses and different lessee

  Given I am a citizena
  And a registered title with characteristics
    | CHARACTERISTICS                               |
    | leasehold                                     |
    | has no lease clauses                          |
    | has a lessee name different to the proprietor |
  When I view the full register of title
  Then Date of Lease is displayed
  And Lease Term is displayed
  And Lease Term start date is displayed
  And Lessor name is displayed
  And Lessee name is displayed
  And the lease clauses are not displayed

Scenario: view lease register as new authenticated user with clauses and lessee as proprietor

  Given I am a citizena
  And a registered title with characteristics
    | CHARACTERISTICS                            |
    | leasehold                                  |
    | has lease clauses                          |
    | has a lessee name matching the proprietor  |
  When I view the full register of title
  Then Date of Lease is displayed
  And Lease Term is displayed
  And Lease Term start date is displayed
  And Lessor name is displayed
  And Lessee name is displayed
  And the lease clauses are displayed

Scenario: Citizen can only view private register if logged in

  Given a registered title
  When I view the private register
  Then I am prompted to login as a private citizen

Scenario: Private Register with Title Extents

  Given I am a citizena
  And a registered title with characteristics
    | CHARACTERISTICS                   |
    | has a polygon with easement       |
    | has a doughnut polygon            |
  When I view the full register of title
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
