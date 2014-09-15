@wip
Feature: Process change of name by way of marriage

Scenario: Caseworker can process a change of name by way of marriage request and update the title of register

  Given I am a caseworker
  And a change of name by marriage application that requires checking
  And I view the check worklist
  When I view more details of the change of name by marriage request
  Then I can see the following information displayed
   | INFORMATION                    |
   | Change of name request details |
   | Title Number                   |
  And an option to approve then change of name request

  When I approve the change of name request
  Then the register of title is updated with the new name
