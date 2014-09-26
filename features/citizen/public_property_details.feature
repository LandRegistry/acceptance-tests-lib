@property-frontend
Feature: View property details on gov.uk

Scenario: Citizen View public register

  Given I am a citizen
  And a registered title
  When I view the property details on gov.uk
  Then I can see the following information displayed
    | INFORMATION      |
    | Title Number     |
    | Property Address |
    | Price Paid       |

Scenario: Citizen View public register without clauses and different lessee

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS                               |
    | leasehold                                     |
    | has no lease clauses                          |
    | has a lessee name different to the proprietor |
  When I view the property details on gov.uk
  Then I can see the following information displayed
    | INFORMATION           |
    | Date Of Lease         |
    | Lease Term            |
    | Lease Term Start Date |
    | Lessor Name           |
    | Lessee Name           |
  And I cannot see the following information displayed
    | INFORMATION           |
    | Lease Clauses         |

Scenario: Citizen View public register with clauses and lessee as proprietor

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS                            |
    | leasehold                                  |
    | has lease clauses                          |
    | has a lessee name matching the proprietor  |
  When I view the property details on gov.uk
  Then I can see the following information displayed
    | INFORMATION           |
    | Date Of Lease         |
    | Lease Term            |
    | Lease Term Start Date |
    | Lessor Name           |
    | Lease Clauses         |
  And I cannot see the following information displayed
    | INFORMATION           |
    | Lessee Name           |

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
  Then I can see the following information displayed
    | INFORMATION                   |
    | multiple polygons             |
    | whole polygin is in view      |
    | the polygons match the title  |
    | the polygons are edged in red |
    | there is a donut polygon      |
    | there is a normal polygon     |
    | there is no easement          |
    | the map can't be zoomed       |
    | the map can't be moved        |
    | the polygons are over a map   |
