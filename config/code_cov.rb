require 'simplecov'
SimpleCov.minimum_coverage MIN_CODE_COVERAGE
SimpleCov.start do
  # add_filter 'features/'
  # add_filter 'config/'
  # add_filter 'helpers/'
end

ENV['CODECOV_TOKEN']='4d2c59d8-d7a0-4f30-aae0-4357dac3b199'

# if ENV['CI']=='true'
#   require 'codecov'
#   SimpleCov.formatter = SimpleCov::Formatter::Codecov
# end