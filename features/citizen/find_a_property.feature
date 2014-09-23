Feature: Find a property on gov.uk and view its details

@performance_test_script
Scenario: A user can find a property and view its details

  Given I am a user
  And a registered title
  When I search for the property on gov.uk
  Then the property details page is displayed
  And the Property Address is displayed
  And Tenure is displayed
  And Class of Title is displayed
  And Price Paid is displayed
  And I have the option to view the full register

Scenario: A user cannot find a property that does not exist

  Given I am a user
  When I search for a property on gov.uk that does not exist
  Then I get a no results are found message
