Feature: Users
    Admins can see a list of users.
    They're able to search using different terms and specifying different fields.

  Background:
    Given I am an admin
    And I attempt to visit the Users list

  Scenario Outline: Searching the users list on a browser without JavaScript
    Given I have JavaScript disabled
    And the following boxes are checked: <checkboxes>
    And I search for the following term: <search_term>
    Then I should see the following results: <expected_results>

    Examples:
      | search_term | checkboxes                                  | expected_results |
      | cwl1        | firstname, surname, grad_year, phone, email | cwl1, cwl10, cwl11, cwl12, cwl13, cwl14|
      | cwl12       | firstname, surname, grad_year, phone, email | cwl12 |
      | Loftus      | surname                                     | cwl   |

  @javascript
  Scenario Outline: Searching the users list with JavaScript enabled
    Given I have JavaScript enabled
    And the following boxes are checked: <checkboxes>
    And I search for the following term: <search_term>
    Then I should see the following results: <expected_results>

    Examples:
      | search_term | checkboxes                                  | expected_results |
      | cwl1        | firstname, surname, grad_year, phone, email | cwl1, cwl10, cwl11, cwl12, cwl13, cwl14, cwl15, cwl16, cwl17, cwl18, cwl19|
      | cwl12       | firstname, surname, grad_year, phone, email | cwl12 |
      | Loftus      | surname                                     | cwl   |