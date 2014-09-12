Feature: Check worklist

Scenario: View Change of Name in work queue

  Given I am a caseworker
  And a change of name by marriage application that requires checking
  When I view the check worklist
  Then Title Number is displayed in the worklist
  And Date Submitted is displayed in the worklist
  And Application Type shows as change of name in the worklist
  And queue is ascending by order of submission
