Feature: Navigation
    There should be a menu containing relevant navigational links
    Only links that are authorised to the current user should be displayed

  Scenario: Guest user accesses homepage
    Given I am a guest
    When I access the homepage
    Then I should see links for the following pages: Home, Jobs
  
  Scenario: Logged in user accesses homepage
    Given I am a user
    When I access the homepage
    Then I should see links for the following pages: Home, Jobs, Profile
  
  Scenario: Logged in administrator accesses homepage
    Given I am an admin
    When I access the homepage
    Then I should see links for the following pages: Home, Jobs, Profile, Users, Broadcasts