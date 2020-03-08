namespace :mokio_install do
  desc 'Create default Mokio::ModulePositions'
  task create_configuration_file: :environment do
    unless File.exist?("#{Rails.root}/config/initializers/mokio.rb")
      Rails::Generators.invoke('mokio:install')
    else
      puts "File already exists".brown
    end
  end
end