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
      run "etags -R ."
    end


    private

    def run(cmd)
      system_with_rvm(cmd)
    end

    def system_with_rvm(cmd)
      system "$SHELL -c 'cd .; #{cmd}'"
    end

  end

end
