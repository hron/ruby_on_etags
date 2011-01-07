require 'bundler'
Bundler::GemHelper.install_tasks

require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber)

require 'rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.skip_bundler = false
end
