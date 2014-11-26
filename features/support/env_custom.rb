# MONITOR CODE COVERAGE
require 'simplecov'

# SUPPORT JAVASCRIPT FOR SPECIFIC CUCUMBER SCENARIOS
# I use Poltergeist because it is headless and a little quicker than selenium. It's also pre-installed on Travis by default.
# The JavaScript driver is, naturally, much slower than a non JavaScript driver, so I've only used the `@javascript` tag where necessary
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist #default driver when you using @javascript tag

# CLEAN DATABASE IN BETWEEN SCENARIOS
# Credit mostly to Helen Harman:
# https://www.facebook.com/Se31520/posts/689637187799632?comment_id=689646561132028&offset=0&total_comments=1
require 'database_cleaner'
Before do
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.start
  DatabaseCleaner.clean
  load Rails.root.join('db/seeds.rb')
end
After do |scenario|
  DatabaseCleaner.clean
end