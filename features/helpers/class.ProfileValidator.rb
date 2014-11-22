class ProfileValidator

  @html_element_ids = {
    "first name".to_sym  => "#user_firstname",
    "surname".to_sym     => "#user_surname",
    "email" .to_sym      => "#user_email",
    "phone".to_sym       => "#user_phone",
    "grad year".to_sym   => "#user_grad_year",
    "jobs status".to_sym => "#user_jobs"
  }

  @valid_inputs = {
    "first name".to_sym => [
      "Evangeline",
      "Abe"
    ],
    "surname".to_sym    => [
      "Ashton",
      "O'Hara",
      "Newton-Boris"
    ],
    "email".to_sym      => [
      "cba1@aber.ac.uk"
    ],
    "phone".to_sym      => [
      "01970422242"
    ],
    "grad year".to_sym  => [
      "1982"
    ],
    "jobs status".to_sym => [
      "1",
      "0"
    ]
  }

  @invalid_inputs = {
    "first name".to_sym => [
      "",
      #{}"Chris8",
      "&;DROP"
    ],
    "surname".to_sym    => [
      "",
      #{}"Chris8",
      "&;DROP"
    ],
    "email".to_sym      => [
      "cwl@aber.ac.uk", # invalid as it would be a duplicate entry in the database
      "a@aber",
      "cwl2000@aber.ac@.uk"
    ],
    "phone".to_sym      => [
      "01970 42224",     # missing one digit
      "+447843281733"   # valid in some applications, but we've made a business decision that ours should disclude such phone numbers for the sake of data integrity
    ],
    "grad year".to_sym  => [
      "1682",           # too far in the past (before Aberystwyth was even founded!)
      "2020"            # in the future - can't have graduated yet
    ],
    "jobs status".to_sym => [
      "wibble"          # not a boolean
    ]
  }

  def self.prepare(options)
    @field_to_get_values_for = options[:field_description].to_sym
    @valid_inputs_required  = (options[:valid_inputs] == "valid")
  end

  def self.field_and_values_are_not_empty
    return !ProfileValidator::get_field.nil? && !ProfileValidator::get_values.nil?
  end

  def self.get_field
    return @html_element_ids[@field_to_get_values_for.to_sym]
  end

  def self.get_values
    if (@values_required == "valid")
      return @valid_inputs[@field_to_get_values_for]
    else
      return @invalid_inputs[@field_to_get_values_for]
    end
  end
end