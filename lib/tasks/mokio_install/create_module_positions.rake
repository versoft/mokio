namespace :mokio_install do
  desc 'Create default Mokio::ModulePositions'
  task create_module_positions: :environment do
    unless Mokio::ModulePosition.any?
      Mokio::ModulePosition.create!(name: 'footer')
      puts "Created default module position 'footer'".green
    else
      puts 'Mokio::ModulePositions already exist'.brown
    end
  end
end