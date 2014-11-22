Feature: Editing a user's profile
    Users have the ability to edit their profile to keep their information up to date.
    Administrators may also update the information of other users.

  Scenario: Guest should not be able to access the 'Edit Profile' page for any user
    Given I am a guest
    When I attempt to visit another user's 'Edit Profile' page
    Then I should be redirected to the login screen

  Scenario: User should not be able to access the 'Edit Profile' page for any user
    Given I am a user
    When I attempt to visit another user's 'Edit Profile' page
    Then I should be blocked from seeing the content

  Scenario: User should be able to access the 'Edit Profile' page for their own profile
    Given I am a user
    When I attempt to visit my own 'Edit Profile' page
    Then I should successfully see the 'Edit Profile' page

  Scenario: Admin should be able to access the 'Edit Profile' page for any user
    Given I am an admin
    When I attempt to visit another user's 'Edit Profile' page
    Then I should successfully see the 'Edit Profile' page

  Scenario: Non-existent profiles should redirect to users page
    Given I am an admin
    When I attempt to visit a non-existent user's 'Edit Profile' page
    Then I should be redirected to the page of users

  # No need to check if guest can edit a user's profile,
  # or if a user can edit another user's profile - these tests are
  # already covered by the fact that guests/other users can't
  # even ACCESS the 'Edit Profile' page for a different user.

  # Scenario: User updates their name with a valid name
  #   Given I am a user
  #   When I edit my profile with a valid new name
  #   Then the changes should be saved

  # Scenario: User attempts to update their name with an invalid name
  #   Given I am a user
  #   When I edit my profile with an invalid new name
  #   Then the changes should NOT be saved

  # Scenario: User updates their email with a valid email
  #   Given I am a user
  #   When I edit my profile with a valid new email
  #   Then the changes should be saved

  # Scenario: User attempts to update their email with an invalid email
  #   Given I am a user
  #   When I edit my profile with an invalid new email
  #   Then the changes should NOT be saved

  # Scenario: User updates their grad year with a grad year
  #   Given I am a user
  #   When I edit my profile with a valid new grad year
  #   Then the changes should be saved

  # Scenario: User attempts to update their grad year with an invalid grad year
  #   Given I am a user
  #   When I edit my profile with an invalid new grad year
  #   Then the changes should NOT be saved

  