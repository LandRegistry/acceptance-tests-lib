Feature: creating and retrieving a register

Scenario: get a register record
Given a register entry exists
When I search by an existing titlenumber
Then the register is returned in JSON format