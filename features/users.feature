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