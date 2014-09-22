Feature: Performance test scenario

@performance_test
Scenario: Private Register with Title Extents
  Given I want to run a performance
  And I have the following scenarios
    | SCENARIO                                                               | USERS |
    | view freehold register as citizen                                      | 15    |
    | Create relationship token for buyers                                   | 2     |
    | Processing Absolute Freehold First Registration with 1 proprietor (3)  | 2     |
    | Citizen authorises the conveyancer client relationship                 | 2     |
  And I run for 1 minute
  And I ramp up 1 user every 1 seconds
  When I run the performance test
  Then I expect less than 10 failures
  And the scenarios response times were below:
    | SCENARIO                                                               | SECONDS |
    | view freehold register as citizen                                      | 10    |
    | Create relationship token for buyers                                   | 5     |
    | Processing Absolute Freehold First Registration with 1 proprietor (3)  | 5     |
    | Citizen authorises the conveyancer client relationship                 | 7     |
