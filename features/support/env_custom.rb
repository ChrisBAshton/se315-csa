# MONITOR CODE COVERAGE
require 'simplecov'
SimpleCov.start do
  add_filter File.expand_path('features/')
end

if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

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