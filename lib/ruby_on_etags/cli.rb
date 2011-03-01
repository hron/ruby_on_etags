require 'thor'
require 'ruby_on_etags/core'

module RubyOnEtags

  class CLI < Thor

    desc "build", "Build TAGS for whole project."
    def build
      begin
        RubyOnEtags::Core.new.build_tags
      rescue Bundler::GemNotFound
        puts "Install missing gems with `bundle install`"
      end
    end

    desc "watch", "Watch for changes in project directory and build TAGS when needed."
    def watch
      system "watchr -e 'watch(\"\.rb\") { system \"roetags build &>/dev/null\" }; puts \"Watching...\"'"
    end

  end

end
