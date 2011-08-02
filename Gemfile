source "http://rubygems.org"

# Specify your gem's dependencies in ruby_on_etags.gemspec
gemspec

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem('rb-inotify',
      :git    => 'git://github.com/hron/rb-inotify.git',
      :branch => 'fix-guard-crash-when-file-is-deleted-very-fast')
  gem 'libnotify'
end
