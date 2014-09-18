@wip
Feature: Process change of name by way of marriage

Scenario: Caseworker can process a change of name by way of marriage request and update the title of register

  Given I am a caseworker
  And a change of name by marriage application that requires reviewing by a caseworker
  And I view the caseworker worklist
  When I approve the change of name by way of marriage request
  Then the register of title is updated with the new name
