# MONITOR CODE COVERAGE
require 'simplecov'

# SUPPORT JAVASCRIPT FOR SPECIFIC CUCUMBER SCENARIOS
# I use Poltergeist because it is headless and a little quicker than selenium. It's also pre-installed on Travis by default.
# The JavaScript driver is, naturally, much slower than a non JavaScript driver, so I've only used the `@javascript` tag where necessary
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist #default driver when you using @javascript tag

# run this once before running any Cucumber tests, to set defaults and clean database
DatabaseCleaner.strategy = :truncation
Cucumber::Rails::World.use_transactional_fixtures = false
DatabaseCleaner.clean

# CLEAN DATABASE IN BETWEEN SCENARIOS
require 'database_cleaner'
Before do
  DatabaseCleaner.start
  load Rails.root.join('db/seeds.rb')
end
After do |scenario|
  DatabaseCleaner.clean
end