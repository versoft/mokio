module Mokio
  module Copy #:nodoc:all
    class ViewsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path('../../../../../app/views/', __FILE__)

      desc "Copy a Mokio views into your application."

      def generate_views
        directory "mokio", "app/views/mokio"
      end
    end
  end
end