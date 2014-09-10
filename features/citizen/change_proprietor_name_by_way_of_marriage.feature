Feature: Change proprietor name by way of marriage

Scenario: Proprietor can change name on title after they have been married
Given I am the proprietor of a registered title
When I provide details of my change of name by marriage
Then the details of my change of name by marriage request are reflected back to me in a statement

When I confirm the statement reflecting my change of name by marriage is accurate and submit it
Then I receive an acknowledgement my request has been sent to Land Registry


Scenario: Proprietor must confirm change of name before submitting change of name by way of marriage details
Given I am the proprietor of a registered title
When I provide details of my change of name by marriage
Then the details of my change of name by marriage request are reflected back to me in a statement

When I do not confirm the statement reflecting my change of name by marriage is accurate and submit it
Then the details of my change of name by marriage request are reflected back to me in a statement


Scenario: Proprietor must fill in all mandatory fields before submitting change of name by way of marrige request
Given I am the proprietor of a registered title
When I submit my change of name by way of marriage details without entering any information
Then a "This field is required." message for "error_proprietor_new_full_name" is returned
And a "This field is required." message for "error_partner_name" is returned
And a "This field is required." message for "error_marriage_date" is returned
And a "This field is required." message for "error_marriage_place" is returned
And a "This field is required." message for "error_marriage_certificate_number" is returned


Scenario: Registered users who are not the proprietor of a property cannot request to change a proprietor name
Given a registered title
And I am not the proprietor
And I have private citizen login credentials
When I try to make a change of name by marriage request for the title
Then I get an unauthorised message
