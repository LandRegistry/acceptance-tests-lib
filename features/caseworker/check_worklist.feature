Feature: Check worklist

Scenario: View Change of Name in work queue

  Given I am a caseworker
  And a change of name by marriage application that requires checking
  When I view the check worklist
  Then I can see the following information displayed
     | INFORMATION                              |
     | Title Number In Worklist                 |
     | Date Request Was Submitted               |
     | Application Type Of Change Name Marriage |
