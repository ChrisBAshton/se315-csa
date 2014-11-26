require 'simplecov'
SimpleCov.minimum_coverage MIN_CODE_COVERAGE
SimpleCov.start do
  add_filter 'features/'
  add_filter 'config/'
  add_filter 'helpers/'
end

if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end