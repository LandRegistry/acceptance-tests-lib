Feature: View full register of title

Scenario: Citizen can view full register of title but cannot edit it

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS           |
    | two proprietors           |
    | has a charge              |
    | has no charge restriction |
  When I view the full register of title
  Then I do not have the option to edit the register

Scenario: Proprietor can view full register of title

  Given I am a citizen
  And I am the proprietor of a registered title
  When I view the full register of title
  Then I have the option to edit the register

@performance_test_script
Scenario: view freehold register as existing authenticated user with charge but no restriction

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS           |
    | two proprietors           |
    | has a charge              |
    | has no charge restriction |
  When I view the full register of title
  Then I can see the following information displayed
    | INFORMATION      |
    | Title Number     |
    | Proprietors      |
    | Property Address |
    | Price Paid       |
    | Tenure           |
    | Class Of Title   |
    | Company Charge With No Restriction   |

Scenario: view freehold register as existing authenticated user with charge and a restriction

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS            |
    | has a charge               |
    | has a charge restriction   |
  When I view the full register of title
  Then I can see the following information displayed
    | INFORMATION                          |
    | Register Details                     |
    | Company Charge With A Restriction    |

Scenario: view lease register as new authenticated user without clauses and different lessee

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS                               |
    | leasehold                                     |
    | has no lease clauses                          |
    | has a lessee name different to the proprietor |
  When I view the full register of title
  Then I can see the following information displayed
    | INFORMATION           |
    | Register Details      |
    | Date Of Lease         |
    | Lease Term            |
    | Lease Term Start Date |
    | Lessor Name           |
    | Lessee Name           |
  And I cannot see the following information displayed
    | INFORMATION           |
    | Lease Clauses         |

Scenario: view lease register as new authenticated user with clauses and lessee as proprietor

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS                            |
    | leasehold                                  |
    | has lease clauses                          |
    | has a lessee name matching the proprietor  |
  When I view the full register of title
  Then I can see the following information displayed
    | INFORMATION           |
    | Register Details      |
    | Date Of Lease         |
    | Lease Term            |
    | Lease Term Start Date |
    | Lessor Name           |
    | Lessee Name           |
  And I cannot see the following information displayed
    | INFORMATION           |
    | Lease Clauses         |

Scenario: Citizen can only view private register if logged in

  Given a registered title
  When I view the private register
  Then I am prompted to login as a private citizen

Scenario: Private Register with Title Extents

  Given I am a citizen
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
