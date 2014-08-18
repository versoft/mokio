module Mokio
  module Copy #:nodoc:all
    class AssetsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path('../../../../../app/assets/', __FILE__)

      desc "Copy a Mokio assets into your application."

      def generate_assets
        directory "fonts",       "app/assets/fonts"
        directory "images",      "app/assets/images"
        directory "javascripts", "app/assets/javascripts"
        directory "stylesheets", "app/assets/stylesheets"
      end
    end
  end
end