Feature: Logging in
    There should be a way of logging in using persistently stored credentials
    Invalid credentials should not allow me to log in
    Once logged in, there should be an option to log out

  Scenario: Logging in with invalid credentials
    Given I am a guest
    When I try to log in with invalid credentials
    Then I should NOT succeed in logging in

  Scenario: Logging in with correct credentials
    Given I am a guest
    When I try to log in with valid credentials
    Then I should succeed in logging in

  Scenario: Logging out
    Given I am a user
    When I try to log out
    Then I should succeed in logging out