[![Build Status](https://magnum.travis-ci.com/ChrisBAshton/se315-csa.svg?token=HSfkP4Tffj4JT2ugyno9&branch=master)](https://magnum.travis-ci.com/ChrisBAshton/se315-csa)

# CS-Alumni Application

This is a Ruby on Rails application for Aberystwyth Computer Science Alumni, originally designed and written by Chris Loftus (encapsulated in the [first commit](https://github.com/ChrisBAshton/se315-csa/commit/d8663a96d59351f3598384069411a26e9fdcf864)). Subsequent commits are my own work.

As part of the SE31520 "Internet-Based Applications" assignment, I've further developed this existing project by:

* Adding extensive Cucumber tests
* Fixing existing functional and unit tests
* Fixing broken functionality as a consequence of writing these tests

# Installation

## Pre-requisites

* Ruby v2.2.1 or above
* Rails v4.1.5 or above
* Homebrew
* ImageMagick

## Performing the installation

Fork the repository, then `cd` into the directory containing this README.

* `bundle install` - to install the required Gems
* `rake db:migrate` - to create the database
* `rails s` - to fire up the Rails server

Now you can go to http://localhost:3000/ to view the CSA project.

# Testing the application

My enhancements to the project include a comprehensive testing suite. You can validate the integrity of your project build by running:

* `rake test:units` - to run the unit tests.
* `rake test:functionals` - to run the functional tests.
* `cucumber features` - to run the Cucumber tests.

Or, if you're feeling lazy:

`rake` - to run all the tests.

# Contributing to CSA

You've downloaded and installed the CSA project and now you want to add some additional functionality. Great stuff!

Ideally, you should develop your enhancement in a test-driven way. Follow these steps:

* Before you do anything, make sure the existing tests pass (see [Testing the application](https://github.com/ChrisBAshton/se315-csa#testing-the-application)).
* Write a Cucumber feature describing your new functionality.
* Develop your new functionality incrementally using low-level unit tests (see `/test/models/user_test.rb` for an example).
* If your functionality can be called RESTfully, write some functional tests (see `/test/controllers/users_controller_test.rb` for an example).
* Finally, write the step definitions for your Cucumber feature.
* Make sure all tests pass.
* Push to Git. You may then want to open a Pull Request to merge with my repository.
* Travis CI will automatically test merging the repositories and try running the new build. If the imaginary build passes, I'll be in a position to hit the "Merge" button.
* Congratulations, you've just contributed to CSA!

# To-do List

- [ ] Making the repo & Travis builds public
- [ ] Expanded functional tests
- [ ] Test JavaScript using Jasmine
- [ ] Wraith? (Screenshot comparison tests) - wow marks

Completed:

- [x] Screencast.
- [x] Travis integration
- [x] Code coverage checker
- [x] Get latest Tweet after posting, to make sure it actually reaches Twitter
- [x] Test broadcasting a blank message
- [x] Use case diagram
- [x] Document the updated test architecture (perhaps with diagrams)
- [x] Refactor of Cucumber tests
- [x] Expanded unit tests
- [x] All views internationalised