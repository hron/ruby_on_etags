module Aruba
  module Api

    def install_gems(gemfile)
      write_file("Gemfile", gemfile)
      if ENV['GOTGEMS'].nil?
        run("gem install bundler")
        run("bundle --no-color install")
      end
    end

  end
end
