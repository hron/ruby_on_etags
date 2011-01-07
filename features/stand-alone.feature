@announce
Feature: Integration using rake
  As a developer I want to able to easy install Ruby On ETags
  To have ability build TAGS with all ruby modules involved in a project

  Scenario: Building TAGS with standalone binary
    # Given I run "rvm gemset delete roetags" interactively
    # And I type "yes"
    Given I'm using a clean gemset "roetags"
    And a standard ruby project directory structure
    And I run "cd ../..; gem build ./ruby_on_etags.gemspec; gem install ruby_on_etags-*.gem; rm ruby_on_etags-*.gem"
    When I run "roetags build"
    Then a file named "TAGS" should exist
    # project sources
    And the file "TAGS" should contain "StandardRubyProject"
    # ruby standard library
    And the file "TAGS" should contain "Array"
    # used gem
    And the file "TAGS" should contain "RubyOnEtags"

  # Scenario: Running 'roetags watch'
  #   Given a standard ruby project directory structure
  #   When I run "roetags watch" interactively
  #   Then the output should contain "Watching..."
  #   When I type "^C"
  #   Then the output should contain "Quiting..."
