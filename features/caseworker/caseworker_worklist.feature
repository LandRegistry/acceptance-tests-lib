Feature: caseworker worklist

Scenario: View Change of Name in work queue

  Given I am a caseworker
  And a change of name by marriage application that requires reviewing by a caseworker
  When I view the caseworker worklist
  Then I can see the following information displayed
     | INFORMATION                              |
     | Marriage Details                         |
     | Title Number In Worklist                 |
     | Date Request Was Submitted               |
     | Application Type Of Change Name Marriage |
  And an option to approve the change of name request
