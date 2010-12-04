# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby_on_etags/version"

Gem::Specification.new do |s|
  s.name        = "ruby_on_etags"
  s.version     = RubyOnEtags::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aleksei Gusev"]
  s.email       = ["aleksei.gusev@gmail.com"]
  s.homepage    = "https://github.com/hron/ruby_on_etags"
  s.summary     = "Automatic generation of TAGS for all ruby modules a project use."
  s.description = "Ruby on ETags is a set of rake tasks to help a developer keep TAGS file up to
date."

  s.rubyforge_project = "ruby_on_etags"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("cucumber", "~>0.9.0")
  s.add_development_dependency("rspec", "~>2.1.0")
  s.add_development_dependency("aruba", "~>0.2.6")
  s.add_development_dependency("ruby-debug19", "~>0.11.6")

  s.add_dependency("bundler", "~>1.0.0")
  s.add_dependency("watchr", "~>0.7")
  s.add_dependency("rake", "~>0.8.7")
  s.add_dependency("thor", "~>0.14.6")
end
