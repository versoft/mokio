# frozen_string_literal: true

require 'rake'
require 'mokio'
require 'rails/generators'

namespace :mokio do
  desc 'Create database, running migrations and creating some default data for Mokio application'
  task :install, %i[email password] => :environment do |_t, args|
    args.with_defaults(email: 'admin@bloomnet.eu', password: 'admin')

    puts "Running task: 'rake:db:create'...".cyan
    Rake::Task['db:create'].execute

    puts "\nRunning task: 'rake:db:migrate'...".cyan
    Rake::Task['db:migrate'].execute

    puts "\nCreating initial data...".cyan
    Rake::Task['mokio_install:create_langs'].execute
    Rake::Task['mokio_install:create_menus'].execute
    Rake::Task['mokio_install:create_module_positions'].execute
    Rake::Task['mokio_install:create_default_user'].execute(args)

    puts "\nInstalling Mokio routes...".cyan
    Rake::Task['mokio_install:install_routes'].execute

    puts "\nCreating Mokio initializer file...".cyan
    Rake::Task['mokio_install:create_configuration_file'].execute

    if ActiveRecord::Base.connection_db_config.configuration_hash['adapter'] == 'postgresql'
      puts "\nResetting pg sequence...".cyan
      Rake::Task['mokio_install:reset_pg_sequence'].execute
    end

    puts "\nInstalling webpack..".cyan
    Rake::Task['mokio_install:install_webpack'].execute

    puts "\nMokio is ready to start! Run 'rails server' and go to localhost:3000/backend to see your application in development mode".green
  end

  namespace :menu do
    desc 'Creates menu tree based on menu.yml file'
    task create_final_tree: :environment do
      config = YAML.load_file("#{Rails.root}/config/menu.yml")

      langs = []

      config['langs'].each do |l|
        langs << Mokio::Lang.new(l)
      end

      Mokio::Lang.import langs

      menus = build_menu(config['menus'], nil)

      menus.each do |me|
        me.save(validate: false) # validation needs to be turned off as we create menu elements with editable flag set to false
      end
    end

    # recursively prepares Menu nodes based on given node list (menu_params)
    def build_menu(menu_params, ancestry)
      menus = []
      menu_params.each do |m|
        m['ancestry'] = ancestry
        new_menu = Mokio::Menu.new(m.except('children'))
        menus << new_menu

        unless m['children'].nil?
          menus += build_menu(m['children'], ancestry.blank? ? m['id'].to_s : ancestry + "/#{m['id']}")
        end
      end
      menus
    end
  end
end
