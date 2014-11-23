Feature: Users
    Admins can see a list of users,
    Create new users, and
    Delete existing users from the system

  Scenario: List of users
    Given I am an admin
    When I attempt to visit Users list
    Then I should see a list of users

  Scenario: Adding a new user with valid inputs
    Given I am an admin
    When I attempt to add a new user with valid inputs
    Then I should succeed in creating that user

  Scenario: Adding a new user with invalid inputs
    Given I am an admin
    When I attempt to add a new user with invalid inputs
    Then I should see an error

  Scenario: Delete existing user
    Given I am an admin
    When I attempt to delete an existing user
    Then I should succeed in deleting that user

  # Scenario: Delete non-existent user
  #   Given I am an admin
  #   When I attempt to delete a non-existent user
  #   Then I should see an error