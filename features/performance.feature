Feature: Performance test scenario

Scenario: Private Register with Title Extents
  Given I want to run a performance
  And I have the following scenarios
    | SCENARIO                                                                             | USERS |
    | view freehold register as citizen                                                    | 1    |
    | view register as new authenticated user | 1   |
  And I run for 60 minutes
  And I ramp up 1 user every 1 seconds
  When I run the performance test
  Then I expect less than 10 failures
  And the scenarios response times were below:
  | SCENARIO                                                                             | SECONDS |
  | view freehold register as citizen                                              | 0.5     |
  | view register as new authenticated user | 10      |
