Given /^a standard ruby project directory structure$/ do
  steps %Q{
    Given a file named "Rakefile" with:
      """
      require 'bundler'
      Bundler.setup

      """
    And a file named "lib/standard_ruby_project.rb" with:
      """
      module StandardRubyProject
      end
      """
  }

  install_gems <<-G
    gem 'ruby_on_etags', :path => '../..'
  G
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
