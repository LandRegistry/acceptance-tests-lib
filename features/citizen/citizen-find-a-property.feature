@service-frontend @search-api
Feature: Citizen find a property

Scenario: No Title Number match for citizen
Given I am a citizen
And I am searching for that property
When I enter an incorrect Title Number (non-matching)
And I search
Then no results are found

Scenario: Exact Title Number match for citizen
Given I have a registered propertyB
And I am a citizen
And I am searching for that property
When I enter the exact Title Number
And I search
Then the citizen register is displayed
