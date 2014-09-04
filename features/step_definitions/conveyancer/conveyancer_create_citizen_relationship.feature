Scenario: Create relationship token for buyers
Given I am a verified Conveyancer
And I have a registered property
And am acting on behalf of 2 buyers
When I select the property
And I enter my clients details
Then a relationship token is generated


I have a registered property with characteristicsB
      | CHARACTERISTICS           |
      | two proprietors           |
      | has a charge              |
      | has no charge restriction |
    And I am still authenticated
