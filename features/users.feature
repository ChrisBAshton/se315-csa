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

  Scenario Outline: Searching the users list on a browser without JavaScript
    Given I have JavaScript disabled
    When I attempt to visit the Users list
    And the following boxes are checked: <checkboxes>
    And I search for the following term: <search_term>
    Then I should see the following results: <expected_results>

    Examples:
      | search_term | checkboxes                                            | expected_results |
      | cwl1        | 'firstname', 'surname', 'grad_year', 'phone', 'email' | 'cwl1', 'cwl10', 'cwl11', 'cwl12', 'cwl13', 'cwl14', 'cwl15', 'cwl16', 'cwl17', 'cwl18', 'cwl19'|
      | cwl12       | 'firstname', 'surname', 'grad_year', 'phone', 'email' | 'cwl12' |
      | Loftus      | 'surname'                                             | 'cwl12' |


  @javascript
  Scenario: Searching the users list with JavaScript enabled
    Given I have JavaScript enabled
    When I attempt to visit the Users list
    And I search for users
    Then I should see the results