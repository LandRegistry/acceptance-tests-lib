Feature: Confirm applications are healthy

Scenario: system-of-record is healthy
  Given the app at lr-system-of-record
  When I GET to /health
  Then I should get a 200 status code

Scenario: casework-frontend is healthy
  Given the app at lr-casework-frontend
  When I GET to /health
  Then I should get a 200 status code

Scenario: property-frontend is healthy
  Given the app at lr-property-frontend
  When I GET to /health
  Then I should get a 200 status code

Scenario: mint is healthy
  Given the app at lr-mint
  When I GET to /health
  Then I should get a 200 status code

Scenario: search-api is healthy
  Given the app at lr-search-api
  When I GET to /health
  Then I should get a 200 status code

Scenario: service-frontend is healthy
  Given the app at lr-service-frontend
  When I GET to /health
  Then I should get a 200 status code
