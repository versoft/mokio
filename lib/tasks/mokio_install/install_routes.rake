namespace :mokio_install do
  desc 'Add mokio routing to routes.rb'
  task install_routes: :environment do |_t|
    path = "#{Rails.root}/config/routes.rb"
    text = File.read(path)
    unless Rails.application.routes.url_helpers.method_defined?(:mokio_url)
      File.open(path, 'w') do |file|
        file.puts text.gsub(/Rails.application.routes.draw do/, "Rails.application.routes.draw do \n  mount Mokio::Engine => '/backend' \n mount Ckeditor::Engine => '/ckeditor'")
      end
    end
  end
end