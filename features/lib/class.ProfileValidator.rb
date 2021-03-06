require 'yaml'

# ProfileValidator converts the valid/invalid profile attributes from various YAML files and returns them in a format that is useful for performing assertions.
class ProfileValidator

  # Initial setup - reads the YAML files and stores results as private arrays of hashes.
  def self.init
    base_user_yaml         = YAML.load_file('features/lib/user_base.yml')
    invalid_overrides_yaml = YAML.load_file('features/lib/user_overrides--invalid.yml')
    valid_overrides_yaml   = YAML.load_file('features/lib/user_overrides--valid.yml')

    @base_user     = base_user_yaml["base"].symbolize_keys
    @invalid_users = ProfileValidator::get_array_of_hashes_from_yaml invalid_overrides_yaml
    @valid_users   = ProfileValidator::get_array_of_hashes_from_yaml valid_overrides_yaml
    
    # base user is also a valid user, so we can push to the valid users array
    @valid_users.push(@base_user.clone)
  end

  # Helper method called by self.init to process the yaml files.
  def self.get_array_of_hashes_from_yaml(yaml)
    the_array = []
    yaml.each do |inputs, values|
      hash = {}
      values = values.symbolize_keys
      values.each do |attribute, value|
        hash[attribute] = value
      end
      the_array.push(hash)
    end
    return the_array
  end

  # converts English-language field names into symbols, to provide quick and easy lookups.
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

  # Returns an array of Hashes, each containing all-valid attributes, e.g.
  # [
  #   {
  #     firstname:     "Evangeline",
  #     surname:       "Ashton",
  #     email:         "cba1@aber.ac.uk",
  #     phone:         "",
  #     grad_year:     "1984",
  #     jobs:          false,
  #     login:         "cba1",
  #     password:      "test",
  #     password_conf: "test",
  #     picture:       false,
  #   },
  #   ...etc
  # ]
  # 
  def self.get_valid_users
    ProfileValidator::generate_user_list(@valid_users)
  end

  # Returns an array of Hashes, each containing at least one invalid attribute.
  def self.get_invalid_users
    ProfileValidator::generate_user_list(@invalid_users)
  end

  # Helper method called by self.get_valid_users and self.get_invalid_users
  def self.generate_user_list (user_field_overrides)
    users_to_return = []
    user_field_overrides.each do |attributes_to_override|
      user = ProfileValidator::override_base_user(attributes_to_override)
      users_to_return.push(user)
    end
    users_to_return
  end

  # Returns a hash representing user attributes.
  # By default it will return the base user attributes, but anything passed as attributes_to_override will override those attributes of the base user.
  def self.override_base_user (attributes_to_override)
    user = @base_user.clone
    attributes_to_override.each do |key, value|
      user[key] = value
    end
    return user
  end

  # Differs to self.override_base_user in that only one type of attribute is returned, not an entire user.
  # For example, one can request get_field_values(field: "firstname") to return an array of invalid firstname values, as defined in user_overrides--invalid.yml. For valid values, add valid: true into the hash.
  def self.get_field_values(options)
    field_symbol = ProfileValidator::convert_field_to_symbol(options[:field])

    if options[:valid]
      users_to_get_field_values_from = @valid_users
    else
      users_to_get_field_values_from = @invalid_users
    end
    
    ProfileValidator::get_any_available_field_values(users_to_get_field_values_from, field_symbol)
  end

  # Helper method called by self.get_field_values
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

ProfileValidator::init