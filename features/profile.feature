Feature: Editing a user's profile
    Users have the ability to edit their profile to keep their information up to date.
    Administrators may also update the information of other users.

  Scenario: User updates their name with a valid first name
    Given I am a user
    When I edit my profile with a valid first name
    Then the changes should be saved

  Scenario: User attempts to update their name with an invalid first name
    Given I am a user
    When I edit my profile with an invalid first name
    Then the changes should NOT be saved

  Scenario: User updates their name with a valid surname
    Given I am a user
    When I edit my profile with a valid surname
    Then the changes should be saved

  Scenario: User attempts to update their name with an invalid surname
    Given I am a user
    When I edit my profile with an invalid surname
    Then the changes should NOT be saved

  Scenario: User updates their email with a valid email
    Given I am a user
    When I edit my profile with a valid email
    Then the changes should be saved

  Scenario: User attempts to update their email with an invalid email
    Given I am a user
    When I edit my profile with an invalid email
    Then the changes should NOT be saved

  Scenario: User updates their phone with a valid phone
    Given I am a user
    When I edit my profile with a valid phone
    Then the changes should be saved

  Scenario: User attempts to update their phone with an invalid phone
    Given I am a user
    When I edit my profile with an invalid phone
    Then the changes should NOT be saved

  Scenario: User updates their grad year with a grad year
    Given I am a user
    When I edit my profile with a valid grad year
    Then the changes should be saved

  Scenario: User attempts to update their grad year with an invalid grad year
    Given I am a user
    When I edit my profile with an invalid grad year
    Then the changes should NOT be saved

  Scenario: User updates their jobs status
    Given I am a user
    When I edit my profile with a valid jobs status
    Then the changes should be saved

  # TODO - later
  # Scenario: User uploads a valid profile picture
  #   Given I am a user
  #   When I edit my profile with a valid profile picture
  #   Then the changes should be saved

  # Scenario: User uploads an invalid profile picture
  #   Given I am a user
  #   When I edit my profile with an invalid profile picture
  #   Then the changes should be saved
