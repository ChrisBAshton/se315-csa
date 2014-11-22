Feature: Accessing a user's profile
    Users each have a profile page containing their personal details
    Access to user profile information is limited

  Scenario: Guest should not be able to access user profiles
    Given I am a guest
    When I attempt to visit another user's 'Profile' page
    Then I should be redirected to the login screen

  Scenario: User should not be able to access the profile of another user
    Given I am a user
    When I attempt to visit another user's 'Profile' page
    Then I should be blocked from seeing the content

  Scenario: User should be able to access their own profile
    Given I am a user
    When I attempt to visit my own 'Profile' page
    Then I should successfully see the 'Profile' page

  Scenario: Admin should be able to access any profile
    Given I am an admin
    When I attempt to visit another user's 'Profile' page
    Then I should successfully see the 'Profile' page

  Scenario: Non-existent profiles should redirect to users page
    Given I am an admin
    When I attempt to visit a non-existent user's 'Profile' page
    Then I should be redirected to the page of users