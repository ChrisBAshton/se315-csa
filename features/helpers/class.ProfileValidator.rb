class ProfileValidator

  def self.convert_field_to_symbol(field_description)
    symbols = {
      "first name"      => :firstname,
      "surname"         => :surname,
      "email"           => :email,
      "phone"           => :phone,
      "grad year"       => :grad_year,
      "jobs status"     => :jobs,
      "profile picture" => :picture
    }
    symbols[field_description]
  end

  def self.get_valid_users
    ProfileValidator::generate_user_list(ProfileTestData::get_valid_user_overrides)
  end

  def self.get_invalid_users
    ProfileValidator::generate_user_list(ProfileTestData::get_invalid_user_overrides)
  end

  def self.generate_user_list (user_field_overrides)
    users_to_return = []
    user_field_overrides.each do |attributes_to_override|
      user = ProfileValidator::override_base_user(attributes_to_override)
      users_to_return.push(user)
    end
    users_to_return
  end

  def self.override_base_user (attributes_to_override)
    user = ProfileTestData::get_base_user.clone
    attributes_to_override.each do |key, value|
      user[key] = value
    end
    return user
  end

  def self.get_field_values(options)
    field_symbol = ProfileValidator::convert_field_to_symbol(options[:field])

    if options[:valid]
      users_to_get_field_values_from = ProfileTestData::get_valid_user_overrides
    else
      users_to_get_field_values_from = ProfileTestData::get_invalid_user_overrides
    end
    
    ProfileValidator::get_any_available_field_values(users_to_get_field_values_from, field_symbol)
  end

  def self.get_any_available_field_values(users_to_get_field_values_from, field_symbol)
    field_values = []
    users_to_get_field_values_from.each do |user|
      if user.has_key?(field_symbol)
        field_values.push(user.fetch(field_symbol))
      end
    end
    field_values
  end
end