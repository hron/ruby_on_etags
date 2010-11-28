Feature: Integration with any ruby project
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
    When I run "rake GEMS='mechanize-1.0.0, org-ruby-0.5.3' ruby_on_etags:build"
    Then a file named "TAGS" should exist
    And the file "TAGS" should contain "StandardRubyProject"
    And the file "TAGS" should contain "Array"
    And the file "TAGS" should contain "Mechanize"
