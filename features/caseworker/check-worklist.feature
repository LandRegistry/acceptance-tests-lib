@wip
Feature: caseworker worklist

Scenario: View Change of Name in work queue
Given a change of name by marriage application that requires checking
And I am still authenticated as a caseworker
When I view the caseworker worklist
Then Title Number is displayed in the worklist
And Date Submitted is displayed in the worklist
And Application Type shows as change of name in the worklist
And queue is ascending by order of submission
