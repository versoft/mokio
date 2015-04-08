require 'rails/generators/rails/resource/resource_generator'
module Mokio
  class ContentsGenerator < Rails::Generators::ResourceGenerator #:nodoc:

    remove_hook_for :resource_controller
    remove_class_option :actions
    remove_hook_for :template_engine
    remove_hook_for :orm
    remove_hook_for :resource_route

    source_root File.expand_path("../templates/contents/", __FILE__)

    # generate model from mokio template
    def create_model_files
      template 'model.rb', File.join('app/models/mokio', class_path, "#{file_name}.rb")
    end
    # generate controller from mokio template
    def create_controller_files
      template "controller.rb", File.join('app/controllers/mokio', controller_class_path, "#{controller_file_name}_controller.rb")
    end

    def create_template_file
      template "_form.html.slim", File.join("app/views/mokio/#{controller_file_name}/", controller_class_path,"_form.html.slim")
    end

    def create_override_view_file
      template "_sidebar_btn.html.slim" ,File.join('app/views/mokio/overrides/','',"#{file_name}_sidebar_btn.html.slim")
    end

    def create_example_translation_file
      template "../translations/backend_example.yml", File.join("config/locales/","backend_#{self.name.underscore}.yml")
    end

    def create_views_file
      template "views_template.yml",File.join("config/",'',"#{file_name}_views_template.yml.example")
      view_file = "#{Rails.root}/config/#{file_name}_views_template.yml.example"

      if File.exists?(view_file)
        File.open(view_file, 'rb') do |infile|
          File.open("#{Rails.root}/config/views.yml", 'a') do |outfile|
            puts "\n"
            while buffer = infile.read(4096)
              puts buffer
              outfile << buffer
            end
            puts "\n"
          end
        end

        routes_file = File.read("#{Rails.root}/config/routes.rb")
        File.open("#{Rails.root}/config/routes.rb", "w") do |file|
          file.puts routes_file.gsub(/Mokio::Engine.routes.draw do/, "Mokio::Engine.routes.draw do \n\nresources :#{controller_file_name} do \n member do\n   get :update_menu_breadcrumps\n   get :copy\n end \n end")
        end

      end
    end
  end
end