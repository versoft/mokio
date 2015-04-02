require 'rails/generators/rails/resource/resource_generator'
module Mokio
  class ContentsGenerator < Rails::Generators::ResourceGenerator #:nodoc:

    remove_hook_for :resource_controller
    remove_class_option :actions
    remove_hook_for :template_engine
    remove_hook_for :orm
    remove_hook_for :resource_route

    source_root File.expand_path("../templates", __FILE__)

    def create_model_file
      template 'model.rb', File.join('app/models/mokio', class_path, "#{file_name}.rb")
    end

    def create_controller_files
      template "controller.rb", File.join('app/controllers/mokio', controller_class_path, "#{controller_file_name}_controller.rb")
    end

    # template "_form.html.slim", File.join('app/views/mokio', controller_class_path,"_form.html.slim")

  end
end
