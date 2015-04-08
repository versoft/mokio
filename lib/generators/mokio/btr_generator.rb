module Mokio
  class BtrGenerator < Rails::Generators::NamedBase
    # backend translations generator for mokio content
    argument :name, type: :string
    source_root File.expand_path("../templates/translations/", __FILE__)

    def create_example_translation_file
      template "backend_example.yml", File.join("config/locales/","en_backend_#{self.name.underscore}.yml")
    end
  end
end