Feature: Performance test scenario

Scenario: Private Register with Title Extents
  Given I want to run a performance
  And I have the following scenarios
    | SCENARIO                                                               | USERS |
    | view register as new authenticated user  | 1     |
  And I run for 1 minute
  And I ramp up 1 user every 1 seconds
  When I run the performance test
  Then I expect less than 10 failures
  And the scenarios response times were below:
    | SCENARIO                                                               | SECONDS |
    | Processing Absolute Freehold First Registration with 1 proprietor (3)  | 5       |
    | view freehold register as citizen                                      | 3       |
