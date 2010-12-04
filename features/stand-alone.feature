Feature: Integration using rake
  As a developer I want to able to easy install Ruby On ETags
  To have ability build TAGS with all ruby modules involved in a project

  Scenario: Building TAGS with standalone binary
    Given a standard ruby project directory structure
    When I run "roetags build"
    Then a file named "TAGS" should exist
    # project sources
    And the file "TAGS" should contain "StandardRubyProject"
    # ruby standard library
    And the file "TAGS" should contain "Array"
    # used gem
    And the file "TAGS" should contain "RubyOnEtags"
