SimpleCov.minimum_coverage 50

SimpleCov.start 'rails' do
  add_filter 'features/'
  add_filter 'config/'
  add_filter 'helpers/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Mailers', 'app/mailers'
  add_group 'Views', 'app/views'
end

# Allows CodeCov.io to store the results of the code coverage.
# However, also requires paying to see the results, and the code coverage amount is not
# displayed in the shell, so it is best left commented out.
# 
# ENV['CODECOV_TOKEN']='4d2c59d8-d7a0-4f30-aae0-4357dac3b199'
# require 'codecov'
# if ENV['CI'] == 'true'
#   SimpleCov.formatter = SimpleCov::Formatter::Codecov
# end