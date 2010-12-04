require 'spec_helper'

describe RubyOnEtags do

  subject { RubyOnEtags::Core.new }

  it "should be able to detect paths of used gems with Bundler" do
    unset_bundler_env_vars
    install_gems <<-G
      gem 'watchr'
      gem 'thor'
    G

    in_current_dir do
      should have(3).loaded_gems
    end
  end

end
