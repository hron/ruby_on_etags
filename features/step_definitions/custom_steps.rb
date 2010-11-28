Given /^a standard ruby project directory structure$/ do
  steps %Q{
    Given an empty file named "Rakefile"
    And a file named "lib/standard_ruby_project.rb" with:
      """
      module StandardRubyProject
      end
      """
  }
end

Given /^Ruby On ETags is installed$/ do
  steps %Q{
    When I append to "Rakefile" with:
      """
      require 'ruby_on_etags'
      RubyOnEtags.install_tasks
      """
  }
end
