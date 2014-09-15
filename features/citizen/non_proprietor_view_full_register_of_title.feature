Feature: Non proprietor view full register of title

Scenario: Citizen can view full register of title but cannot edit it

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS           |
    | two proprietors           |
    | has a charge              |
    | has no charge restriction |
  When I view the full register of title
  Then I do not have the option to edit the register
