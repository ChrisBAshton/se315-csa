Feature: Users
    Admins can see a list of users,
    Create new users, and
    Delete existing users from the system

  Background:
    Given I am an admin

  Scenario: List of users
    When I attempt to visit the Users list
    Then I should see a list of users

  Scenario: Adding a new user with valid inputs
    When I attempt to add a new user with valid inputs
    Then I should succeed in creating that user

  Scenario: Adding a new user with invalid inputs
    When I attempt to add a new user with invalid inputs
    Then I should see an error

  Scenario: Delete existing user
    When I attempt to delete an existing user
    Then I should succeed in deleting that user

  # Scenario: Delete non-existent user
  #   When I attempt to delete a non-existent user
  #   Then I should see an error

  Scenario: Searching the users list on a browser without JavaScript
    Given I have JavaScript disabled
    When I attempt to visit the Users list
    And I search for users
    Then the I should see the results after submitting my query

  @javascript
  Scenario: Searching the users list with JavaScript enabled
    Given I have JavaScript enabled
    When I attempt to visit the Users list
    And I search for users
    Then the I should see the results automatically