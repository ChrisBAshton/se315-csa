Feature: Editing a user's profile
    Users have the ability to edit their profile to keep their information up to date.
    Administrators may also update the information of other users.

  Scenario Outline: User updates a field with a valid value
    Given I am a user
    When I edit my profile with a valid <field_description>
    Then the changes should be saved

    Examples:
      | field_description |
      | first name        |
      | surname           |
      | email             |
      | phone             |
      | grad year         |
      | jobs status       |
      #| profile picture   |

  Scenario Outline: User attempts to update a field with an invalid value
    Given I am a user
    When I edit my profile with an invalid <field_description>
    Then the changes should NOT be saved

    Examples:
      | field_description |
      | first name        |
      | surname           |
      | email             |
      | phone             |
      | grad year         |
      # no "jobs status" as we cannot assign an invalid value to a checkbox
      #| profile picture   |
