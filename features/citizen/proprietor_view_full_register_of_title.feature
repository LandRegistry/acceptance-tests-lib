Feature: Proprietor view full register of title

Scenario: Proprietor can view full register of title

  Given I am a citizen
  And I am the proprietor of a registered title
  When I view the full register of title
  Then I have the option to edit the register
