@service-frontend @search-api
Feature: Citizen find a property

Scenario: No Title Number match for citizen
Given I am a citizen
And I am searching for that property
When I enter an incorrect Title Number (non-matching)
And I search
Then no results are found

Scenario: Exact Title Number match for citizen
Given I have a registered property
And I am a citizen
And I am searching for that property
When I enter the exact Title Number
And I search
Then the citizen register is displayed
And Audit for public citizen search of title written

@wip
Scenario: Multiple Title Number match for citizen
Given I am a citizen
And I am searching for that property
And at least two registers with the same Title Number beginning exists
When I enter a Title Number with the same prefix
And I search
Then multiple results are displayed
And results show address details
And results show Title Number

@wip
Scenario: View register from multiple results for citizen
Given I am a citizen
And I am searching for that property
And at least two registers with the same Title Number beginning exists
When I enter a Title Number with the same prefix
And I search
And I select a result
Then the citizen register is displayed
