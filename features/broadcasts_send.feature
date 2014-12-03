Feature: Sending new Broadcasts
    Administrators can broadcast news to any combination of feeds

  Background:
    Given I am an admin

  Scenario Outline: Sending a broadcast to specific feeds
    When I attempt to visit New broadcast
    And I attempt to send a broadcast to <feed_type>
    Then the broadcast should be sent successfully

    Examples:
      | feed_type        |
      | all feeds        |
      | the Twitter feed |
      | the email feed   |
      # RSS, Atom, Facebook feeds can be added to these examples as and when they're implemented

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