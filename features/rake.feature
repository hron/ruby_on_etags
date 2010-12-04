Feature: Integration using rake
  As a developer I want to able to easy install Ruby On ETags
  To have ability build TAGS with all ruby modules involved in a project

  Scenario: Installing to use with rake
    Given a standard ruby project directory structure
    When I append to "Rakefile" with:
      """
      require 'ruby_on_etags'
      RubyOnEtags.install_tasks
      """
    And I run "rake -T ruby_on_etags"
    Then the output should contain:
      """
      rake ruby_on_etags:build  # Build TAGS for whole project.
      rake ruby_on_etags:watch  # Watch for changes in project directory and build TAGS when needed.
      """

  Scenario: Building TAGS with rake
    Given a standard ruby project directory structure
    And Ruby On ETags is installed
    When I run "rake ruby_on_etags:build"
    Then a file named "TAGS" should exist
    # project sources
    And the file "TAGS" should contain "StandardRubyProject"
    # ruby standard library
    And the file "TAGS" should contain "Array"
    # used gem
    And the file "TAGS" should contain "RubyOnEtags"
