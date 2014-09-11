Feature: Proprietor view full register of title

Scenario: Proprietor can view full register of title

  Given I am a citizen
  And I am the proprietor of a registered title with characteristics
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
  And I have the option to edit the register
