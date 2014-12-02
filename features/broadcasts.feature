Feature: Broadcasts
    Administrators can broadcast news to any number of feeds,
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

  Scenario Outline: Sending a broadcast to specific feeds
    When I attempt to visit New broadcast
    And I attempt to send a broadcast to <feed_type>
    Then the broadcast should be sent successfully

    Examples:
      | feed_type        |
      | all feeds        |
      | the Twitter feed |
      | the email feed   |

  Scenario: Sending a broadcast to no feeds
    When I attempt to visit New broadcast
    When I attempt to send a broadcast to no feeds
    Then the broadcast should not send at all

  Scenario: Sending a long broadcast to the Twitter feed
    When I attempt to visit New broadcast
    When I attempt to send a long broadcast to the Twitter feed
    Then the broadcast should not send to all feeds

  Scenario: Sending an empty broadcast to any feed
    When I attempt to visit New broadcast
    When I attempt to send an empty broadcast to a valid feed
    Then the broadcast should not send at all