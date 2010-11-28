module RubyOnEtags

  def install_tasks
    namespace :ruby_on_etags do

      desc "Build TAGS for whole project. GEMS='some_gem-1.0.0, another_gem-0.2.1'."
      task :build do
      end

      desc "Watch for changes in project directory and build TAGS when needed."
      task :watch do
      end

    end
  end
  module_function :install_tasks

end
