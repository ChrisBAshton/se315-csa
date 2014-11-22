Feature: Restricting access to specific pages for certain user types
    Guest users can only access the homepage and login options
    Logged in users can access these plus their own profile options
    Administrators can access these plus other users' profiles, and broadcasts
    Non-existent pages should redirect gracefully

  Scenario: Guest users access levels
    Given I am a guest
    Then I should be able to access: Home, Login
    And I should not have access to any other pages
  
  Scenario: Registered users access levels
    Given I am a user
    Then I should be able to access: Home, Login, Profile (own), Edit Profile (own)
    And I should not have access to any other pages
  
  Scenario: Administrator access levels
    Given I am an admin
    Then I should be able to access every page

  Scenario: Attempting to view non-existent profiles should redirect to users page
    Given I am an admin
    When I attempt to visit Profile (non-existent user)
    Then I should be redirected to the Users list

  Scenario: Attempting to edit non-existent profiles should redirect to users page
    Given I am an admin
    When I attempt to visit Edit Profile (non-existent user)
    Then I should be redirected to the Users list