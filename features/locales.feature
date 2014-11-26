Feature: Locales
    The application supports internationalisation so that it can be used by people whose first language may not be English.
    Users can change their preferred language at any time through a simple form.

  Scenario: Changing language from a non-JavaScript browser
    Given I am a guest
    When I change my default language to a valid option
    And I submit it manually
    Then the language of the page should change

  @javascript
  Scenario: Changing language from a JavaScript-enabled browser
    Given I am a guest
    When I change my default language to a valid option
    Then the language of the page should change

  Scenario: Changing language to an invalid option
    Given I am a guest
    When I change my default language to an invalid option
    Then I should see an error message
