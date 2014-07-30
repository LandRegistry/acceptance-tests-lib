Feature: Confirm applications are healthy

Scenario Outline: system-of-record is healthy
  Given the app at <domain>
  When I GET to <path>
  Then I should get a 200 status code

Examples:

| domain                                         | path    |
| http://lr-system-of-record.herokuapp.com       | /health |
| http://lr-casework-frontend.herokuapp.com      | /health |
| http://lr-property-frontend.herokuapp.com      | /health |
| http://lr-property-frontend.herokuapp.com      | /health |
| http://lr-mint.herokuapp.com                   | /health |
| http://lr-search-api.herokuapp.com             | /health |
