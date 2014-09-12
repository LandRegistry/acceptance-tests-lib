Feature: Non proprietor view full register of title

Scenario: Citizen can view full register of title

  Given I am a citizen
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
  And I do not have the option to edit the register
