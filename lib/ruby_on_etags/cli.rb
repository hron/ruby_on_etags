require 'thor'
require 'ruby_on_etags/core'

module RubyOnEtags

  class CLI < Thor

    desc "build", "Build TAGS for whole project."
    def build
      RubyOnEtags::Core.new.build_tags
    end

  end

end
