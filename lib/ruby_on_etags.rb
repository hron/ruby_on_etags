require 'tempfile'
require 'bundler'

module RubyOnEtags

  def install_tasks
    Core.install_tasks
  end
  module_function :install_tasks

  class Core

    def self.install_tasks

      namespace :ruby_on_etags do

        desc "Build TAGS for whole project. GEMS='some_gem-1.0.0, another_gem-0.2.1'."
        task :build do
          self.new.build_tags
        end

        desc "Watch for changes in project directory and build TAGS when needed."
        task :watch do
        end

      end

    end

    def build_tags
      remove_tags
      concatenate_tags_files(build_tags_for_standard_library,
                             *build_tags_for_gems,
                             build_tags_current_dir)
    end

    def build_tags_for_gems
      loaded_gems.map do |gem_spec|
        tags_filename = File.join(cache_dir,
                                  'gems',
                                  "#{gem_spec.name}-#{gem_spec.version.version}",
                                  'TAGS')
        FileUtils.mkdir_p(File.dirname(tags_filename))
        etags(gem_spec.loaded_from, tags_filename)
        tags_filename
      end
    end

    def build_tags_for_standard_library
      File.join(cache_dir, 'rubies', RUBY_VERSION, 'TAGS').tap do |tags_filename|
        FileUtils.mkdir_p(File.dirname(tags_filename))
        dirs = $:.delete_if { |path| path =~ %r|/gems/| }
        run "etags -R -o #{tags_filename} #{dirs.join(' ')}"
      end
    end

    def build_tags_current_dir
      tags_file = Tempfile.new('ruby_on_etags-project-TAGS')
      tags_file.close
      etags(".", tags_file.path)
      tags_file.path
    end

    def concatenate_tags_files(*args)
      File.open("TAGS", 'w') do |tags|
        args.each do |tags_filename|
          tags << IO.read(tags_filename)
        end
      end
    end

    def remove_tags
      FileUtils.rm_f("TAGS")
    end

    def loaded_gems
      File.exists?("Gemfile") ? Bundler.load.specs : []
    end


    private

    def run(cmd)
      system_with_rvm(cmd)
    end

    def system_with_rvm(cmd)
      system "$SHELL -c 'cd .; #{cmd}'"
    end

    def etags(dirs, output)
      run "etags -R -o #{output} #{dirs}"
    end

    def cache_dir
      ENV['RUBY_ON_ETAGS_CACHE'] ||
        File.join(ENV['HOME'], '.ruby_on_tags', 'cache')
    end

  end

end
