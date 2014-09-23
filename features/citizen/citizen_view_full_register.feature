Feature: Citizen view full register of title

@performance_test_script
Scenario: Full register of title

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS           |
    | two proprietors           |
  When I view the full register of title
  Then I can see the following information displayed
    | INFORMATION      |
    | Title Number     |
    | Proprietors      |
    | Property Address |
    | Price Paid       |
    | Tenure           |
    | Class Of Title   |
    | Proprietors      |
  And Audit for private citizen register view written

Scenario: Register of title with a charge but no restriction

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS           |
    | has a charge              |
    | has no charge restriction |
  When I view the full register of title
  Then I can see the following information displayed
    | INFORMATION                          |
    | Register Details          |
    | Company Charge With No Restriction   |

Scenario: Register of title with a charge and a restriction

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

Scenario: Register of title with lease with different lessee and without clauses

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

Scenario: Register of title with clauses and lessee as proprietor

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
    | Lease Clauses         |
