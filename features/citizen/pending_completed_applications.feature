Feature: Property owner view of pending & completed applications

Scenario:As a property owner with pending and completed applications
Given I am a citizen
And I have private citizen login credentials
And I am the proprietor of a registered title
And pending applications exist
And completed applications exist
When I view the full register of title
And  I elect to view requests
Then a separate list of pending requests followed by completed requests are shown in order of receipt by date & time
And the correct data is displayed

Scenario:As a property owner with only pending applications existing
Given I am a citizen
And I have private citizen login credentials
And I am the proprietor of a registered title
And pending applications exist
When I view the full register of title
And I elect to view requests
Then a list of pending requests are shown in order of receipt by date & time
And the correct data is displayed

Scenario:As a property owner with only completed applications existing
Given I am a citizen
And I have private citizen login credentials
And I am the proprietor of a registered title
And completed applications exist
When I view the full register of title
And I elect to view requests
Then a separate list of completed requests are shown in order of receipt by date & time
And the correct data is displayed

Scenario:As a property owner with neither completed nor pending applications
Given I am a citizen
And I have private citizen login credentials
And I am the proprietor of a registered title
When I view the full register of title
Then a view requests option is not displayed


Scenario:As a property owner but not the proprietor of the title
Given I am a citizen
And I have private citizen login credentials
And a registered title
And pending applications exist
When I view the full register of title
Then a view requests option is not displayed

Scenario:As a property owner but not the proprietor of the title who edits the url
Given I am a citizen
And I have private citizen login credentials
And a registered title
And completed applications exist
And I view the full register of title
And a view requests option is not displayed
When I amend the url to directly go to the pending screen
Then an error message is displayed
