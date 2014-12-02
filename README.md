[![Build Status](https://magnum.travis-ci.com/ChrisBAshton/se315-csa.svg?token=HSfkP4Tffj4JT2ugyno9&branch=master)](https://magnum.travis-ci.com/ChrisBAshton/se315-csa)

# CS-Alumni Application

This is a Ruby on Rails application for Aberystwyth Computer Science Alumni, originally designed and written by Chris Loftus (encapsulated in the [first commit](https://github.com/ChrisBAshton/se315-csa/commit/d8663a96d59351f3598384069411a26e9fdcf864). Subsequent commits are my own work.

As part of the SE31520 "Internet-Based Applications" assignment, I've further developed this existing project by:

* Adding extensive Cucumber tests
* Fixing existing functional and unit tests
* Fixing broken functionality as a consequence of writing these tests

# To-do List

- [x] Travis integration
- [x] Code coverage checker
- [x] Get latest Tweet after posting, to make sure it actually reaches Twitter
- [ ] Screencast.
- [x] Test broadcasting a blank message
- [ ] RSPec tests
- [ ] Use case diagram, Data flow diagram, revised database/class designs
- [ ] Document the updated test architecture (perhaps with diagrams)
- [ ] Expanded functional tests
- [ ] Expanded unit tests
- [ ] Cite an article for using only boundaries for tests
- [ ] Increased minimum code coverage levels
- [ ] Refactor of Cucumber tests
- [ ] Test JavaScript using Jasmine
- [ ] Testing that no unencrypted password is stored in the database
- [ ] Implementing an improvement based on the original (overcomplex) class diagram
- [ ] Making the repo & Travis builds public
- [ ] new.html.erb (and others) still has hardcoded English
- [ ] Use the session optimiser from test/controllers/helper.rb for emulating sessions in Cucumber, rather than filling in forms and clicking 'Login'
- [ ] Wraith? (Screenshot comparison tests) - wow marks