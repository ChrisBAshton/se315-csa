Feature: Viewing and removing Broadcasts
    Administrators can...
    View a history of any broadcast in the list
    Remove history of a specific broadcast

  Background:
    Given I am an admin

 Scenario: List of broadcasts
    When I attempt to visit the broadcasts list
    Then I should see a list of broadcasts

  Scenario: Viewing a specific broadcast
    When I attempt to visit a specific broadcast
    Then I should see the broadcast history

  Scenario: Viewing a broadcast that doesn't exist
    When I attempt to visit a broadcast that doesn't exist
    Then I should be redirected to the broadcasts list

  Scenario: Deleting history of a specific broadcast
    When I attempt to visit the broadcasts list
    And I attempt to delete the history of a specific broadcast
    Then I should be successful in deleting it
