# MONITOR CODE COVERAGE
require 'simplecov'

# CLEAN DATABASE IN BETWEEN SCENARIOS
require 'database_cleaner'

# Credit mostly to Helen Harman:
# https://www.facebook.com/Se31520/posts/689637187799632?comment_id=689646561132028&offset=0&total_comments=1
Before do
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.start
  DatabaseCleaner.clean
  load Rails.root.join('db/seeds.rb')
end

After do |scenario|
  DatabaseCleaner.clean
end

# Set a javascript driver to allow JS to be executed
# I use Poltergeist because it is headless and a little quicker than selenium. It's also pre-installed on Travis by default.
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist #default driver when you using @javascript tag