require 'spec_helper'

describe RubyOnEtags do

  subject { RubyOnEtags::Core.new }

  it "should be able to detect paths of used gems with Bundler" do
    unset_bundler_env_vars
    install_gems <<-G
      gem 'mechanize'
      gem 'org-ruby'
    G

    in_current_dir do
      should have(5).loaded_gems
    end
  end

end
