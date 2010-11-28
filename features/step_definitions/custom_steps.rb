Given /^a standard ruby project directory structure$/ do
  steps %Q{
    Given an empty file named "Rakefile"
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

Then /^TAGS should contain definition of "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
