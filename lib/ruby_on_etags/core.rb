require 'tempfile'
require 'bundler'

require 'bundler/definition'
require 'bundler/dependency'
require 'bundler/dsl'
require 'bundler/environment'
require 'bundler/gem_helper'
require 'bundler/graph'
require 'bundler/index'
require 'bundler/installer'
require 'bundler/lazy_specification'
require 'bundler/lockfile_parser'
require 'bundler/remote_specification'
require 'bundler/resolver'
require 'bundler/runtime'
require 'bundler/settings'
require 'bundler/shared_helpers'
require 'bundler/spec_set'
require 'bundler/source'
require 'bundler/shared_helpers'
require 'bundler/ui'

module RubyOnEtags
  class Core

    def self.install_tasks

      namespace :ruby_on_etags do

        desc "Build TAGS for whole project. GEMS='some_gem-1.0.0, another_gem-0.2.1'."
        task :build do
          self.new.build_tags
        end

        desc "Watch for changes in project directory and build TAGS when needed."
        task :watch do
          system "watchr -e 'watch(\"\.rb\") { system \"rake ruby_on_etags:build &>/dev/null\" }'"
        end

      end

    end

    def build_tags
      remove_tags
      tags_files = []
      tags_files << build_tags_for_standard_library
      tags_files += build_tags_for_gems
      tags_files << build_tags_current_dir
      concatenate_tags_files(tags_files)
    end

    def build_tags_for_gems
      gems_in_use.map do |gem_spec|
        tags_filename = File.join(cache_dir,
                                  'gems',
                                  "#{gem_spec.name}-#{gem_spec.version.version}",
                                  'TAGS')
        etags(gem_spec.load_paths, tags_filename, :ctags_flags => "--tag-relative=no")
        tags_filename
      end
    end

    def build_tags_for_standard_library
      File.join(cache_dir, 'rubies', RUBY_VERSION, 'TAGS').tap do |tags_filename|
        dirs = $:.delete_if { |path| path =~ %r|/gems/| }
        etags(dirs, tags_filename, :ctags_flags => "--tag-relative=no")
      end
    end

    def build_tags_current_dir
      tags_file = Tempfile.new('ruby_on_etags-project-TAGS', '.')
      tags_file.close
      etags(["."], tags_file.path)
      tags_file.path
    end

    def concatenate_tags_files(tags_files)
      File.open("TAGS", 'w') do |tags|
        tags_files.each do |tags_filename|
          tags << IO.read(tags_filename)
        end
      end
    end

    def remove_tags
      FileUtils.rm_f("TAGS")
    end

    def gems_in_use
      if File.exists?("Gemfile")
        Bundler.load.specs
      else
        []
      end
    end


    private

    def run(cmd)
      system_with_rvm(cmd)
    end

    def system_with_rvm(cmd)
      system "$SHELL -c 'cd .; #{cmd}'"
    end

    def etags(dirs, output, options = {})
      if !File.exists?(output) || File.zero?(output)
        ctags_additional_flags = options.delete(:ctags_flags) || ""

        FileUtils.mkdir_p(File.dirname(output))
        dirs &&= dirs.map{|d| "'#{d}'"}.join(' ')
        run "ctags #{ctags_additional_flags} -e -R -o '#{output}' #{dirs}"
      end
    end

    def cache_dir
      ENV['RUBY_ON_ETAGS_CACHE'] ||
        File.join(ENV['HOME'], '.ruby_on_tags', 'cache')
    end

  end
end
