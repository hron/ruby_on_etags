require 'spec_helper'

describe RubyOnEtags::Core do

  before do
    @aruba_timeout_seconds = 30
    unset_bundler_env_vars
    use_clean_gemset("roetags")
  end

  context 'when all needed gems are installed' do

    before do
      install_gems <<-G
        gem 'watchr'
        gem 'thor'
      G
    end

    it "should be able to detect paths of used gems with Bundler" do
      in_current_dir do
        should have(3).gems_in_use
      end
    end

  end

end
