class ProfileTestData

  @base_user = {
      firstname:     "Evangeline",
      surname:       "Ashton",
      email:         "cba1@aber.ac.uk",
      phone:         "",
      grad_year:     "1984",
      jobs:          false,
      login:         "cba1",
      password:      "test",
      password_conf: "test",
      picture:       false
  }

  @valid_users = [

    # base user is valid, so should be part of the valid_users list
    @base_user.clone,

    # the other valid users inherit from the base user but override individual attributes
    {
      email: "test@test.com",
      login: "bob"
    },

    {
      firstname:     "Abe",
      surname:       "O'Hara",
      email:         "abc123@google.com",
      phone:         "01970423152",
      grad_year:     "1999",
      jobs:          true,
      login:         "abc123",
      password:      "secret",
      password_conf: "secret"
    },

    {
      email:   "tom@google.com",
      login:   "tom",
      picture: "test/assets/images/profile.jpg"
    },
    
    {
      email:   "bill@google.com",
      login:   "bill",
      picture: "test/assets/images/jpeg.jpeg"
    },
    
    {
      email:   "ben@google.com",
      login:   "ben",
      picture: "test/assets/images/png.png"
    },
    
    {
      email:   "bobby@google.com",
      login:   "bobby",
      picture: "test/assets/images/small.gif"
    }
  ]

  # inherit from the base user but override individual attributes to make the user invalid
  @invalid_users = [
    {
      firstname: ""
    },
    {
      firstname: "&;DROP"
    },
    {
      surname: ""
    },
    {
      surname: "&;DROP"
    },
    {
      grad_year: "2020" # invalid as grad year is in the future
    },
    {
      grad_year: "1682" # too far in the past (before Aberystwyth was even founded!)
    },
    {
      phone: "01234"
    },
    {
      email: "cwl@aber.ac.uk" # invalid as it would be a duplicate entry in the database"
    },
    {
      email: "test@aber"
    },
    {
      email: "cwl2000@aber.ac@.uk"
    },
    {
      password:      "test",
      password_conf: "test2" # invalid - the password and confirmation should match
    },
    {
      phone: "01970 42224"   # missing one digit
    },
    {
      phone: "+447843281733" # valid in some applications, but we've made a business decision that ours should disclude such phone numbers for the sake of data integrity
    },
    {
      picture: "test/assets/images/virus.exe"
    },
    {
      picture: "test/assets/images/virus.jpg" # not a valid image file, but does have the jpg extension
    },
    {
      picture: "test/assets/images/svg.svg"
    },
    {
      picture: "test/assets/images/large.gif" # bigger than the 500Kb filesize limit
    }
  ]

  def self.get_base_user
    return @base_user
  end

  def self.get_valid_user_overrides
    return @valid_users
  end

  def self.get_invalid_user_overrides
    return @invalid_users
  end

end