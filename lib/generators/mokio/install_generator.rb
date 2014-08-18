module Mokio
  class InstallGenerator < Rails::Generators::Base #:nodoc:
    source_root File.expand_path('../templates', __FILE__)

    desc "Creates a Mokio initializer(configuration file) in your application."

    def create_confg_file
      if rails_4?
        template "mokio.rb", "config/initializers/mokio.rb"
      else
        puts "Mokio supports only Rails #{Mokio::SUPPORTED_RAILS} or higher, your version is #{Rails.version}".red
      end
    end

    private

      def rails_4?
        Rails::VERSION::MAJOR == Mokio::SUPPORTED_RAILS
      end
  end
end