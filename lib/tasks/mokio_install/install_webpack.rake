namespace :mokio_install do
  desc 'Installs Webpack'
  task install_webpack: :environment do
    unless File.exist?("#{Rails.root}/config/webpacker.yml")
      Rake::Task['webpacker:install'].execute
    else
      puts "Webpacker is already installed".brown
    end
  end
end