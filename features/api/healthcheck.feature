Feature: Confirm applications are healthy

Scenario: system-of-record is healthy
Given app system-of-record
#When logging is enabled
When I GET to /health
Then I should get a 200 status code 
#Then debug
