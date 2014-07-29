Feature: Confirm applications are healthy

Scenario: system-of-record is healthy
Given the app at "http://lr-system-of-record.herokuapp.com"
When I GET to /health
Then I should get a 200 status code
