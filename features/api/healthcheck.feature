Feature: Confirm applications are healthy

Scenario: system-of-record is healthy
  Given the app at "http://lr-system-of-record.herokuapp.com"
  When I GET to /health
  Then I should get a 200 status code

Scenario: casework-frontend is healthy
  Given the app at "http://lr-casework-frontend.herokuapp.com"
  When I GET to /health
  Then I should get a 200 status code

Scenario: property-frontend is healthy
  Given the app at "http://lr-property-frontend.herokuapp.com"
  When I GET to /health
  Then I should get a 200 status code

Scenario: mint is healthy
  Given the app at "http://lr-mint.herokuapp.com"
  When I GET to /health
  Then I should get a 200 status code

Scenario: search-api is healthy
  Given the app at "http://lr-search-api.herokuapp.com"
  When I GET to /health
  Then I should get a 200 status code
