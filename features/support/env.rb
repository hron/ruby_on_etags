require 'aruba/cucumber'

ENV['RUBY_ON_ETAGS_CACHE'] = File.join("tmp", "ruby_on_etags_cache")

Before do
  FileUtils.rm_rf(ENV['RUBY_ON_ETAGS_CACHE'])
  FileUtils.mkdir_p(ENV['RUBY_ON_ETAGS_CACHE'])
  unset_bundler_env_vars
  @aruba_timeout_seconds = 3
end
