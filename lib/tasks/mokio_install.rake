require 'rake'
require 'mokio'
require 'rails/generators'

namespace :mokio do
  @default_email = "admin@admin.com"
  @default_password = "111111"


  desc "Reset pg columns sequence"
  task reset_pg_sequence: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    puts "Rake::Task mokio:reset_pg_sequence - Success".green
  end

  desc "Add mokio routing to routes.rb"
  task :install_routes => :environment do |t|
    path = "#{Rails.root}/config/routes.rb"
    text = File.read(path)

    if !Rails.application.routes.url_helpers.method_defined?(:mokio_url)
      File.open(path, "w") do |file|
        file.puts text.gsub(/Rails.application.routes.draw do/, "Rails.application.routes.draw do \n  mount Mokio::Engine => '/backend'")
      end
      puts "Rake::Task mokio:install_routes - Success".green
    end
    puts "Rake::Task mokio:install_routes - has been omitted - routes exists"
  end

  desc "Add mokio config"
  task :install_config => :environment do |t|
    unless File.exist?("#{Rails.root}/config/initializers/mokio.rb")
      puts "\n"
      result = Rails::Generators.invoke("mokio:install")
      puts "\n\tCreated initializer(configuration file) in #{result}".green
      puts "Rake::Task mokio:install_config - Success".green
    end
    puts "Rake::Task mokio:install_config - has been omitted - file exists"
  end

  desc "Install heroku rake - without database create"
  task :install_heroku => :environment do |t, args|
    Rake::Task["db:migrate"].execute
    puts "Rake::Task mokio:create_database - Success".green
    Rake::Task["mokio:seed"].execute
    Rake::Task["mokio:install_routes"].execute
    Rake::Task["mokio:install_config"].execute
    puts "Mokio install without creating database - complete"
    puts "Rake::Task mokio:install_heroku - Success".green
  end

  desc "Create mokio database and migrate"
  task :create_database  => :environment do |t|
    puts "\nRunning task: 'rake:db:create'...".green
    Rake::Task["db:create"].execute
    puts "\nRunning task: 'rake:db:migrate'...".green
    Rake::Task["db:migrate"].execute
    puts "Rake::Task mokio:create_database - Success".green
  end

  desc "Seed default mokio database"
  task :seed => :environment do |t, args|
    puts "\nCreating initial data...".green

    default_lang = Mokio::Lang.new({
      :name => Mokio.frontend_default_lang,
      :shortname => Mokio.frontend_default_lang,
      :active => true,
      :menu_id => Mokio.frontend_initial_pl,
      :id => 1
    })

    puts "\n\tCreated default lang '#{default_lang.name}'".green if default_lang.save
    menu = Mokio::Menu.find_by_name(default_lang.shortname)
    puts "\n\tCreated default initial menu '#{menu.name}'".green unless menu.nil?

    top_menu = Mokio::Menu.new({
      name: "top",
      seq: 1,
      deletable: false,
      editable: false,
      lang_id: 1,
      id: 2,
      content_editable: false,
      modules_editable: false,
      fake: true,
      parent: menu,
      slug: "top"
    })

    puts "\n\tCreated default initial menu 'top'".green if top_menu.save(:validate => false)

    Mokio::ModulePosition.create!(:name => 'footer')
    puts "\n\tCreated default module position 'footer'".green

    user = Mokio::User.new({
      email: @default_email,
      password: @default_password,
      password_confirmation: @default_password,
      roles_mask: 1
    })
    puts "\n\tCreated default user '#{@default_email}' with password '#{@default_password}'".green if user.save(:validate => false)

    if(ActiveRecord::Base.configurations[Rails.env]['adapter']) == "postgresql"
      puts "PG database detected - Success".green
      Rake::Task["mokio:reset_pg_sequence"].execute
    end

    puts "Rake::Task mokio:seed_default - Success".green

  end

  desc "Create database, running migrations and creating some default data for Mokio application"
  task :install_default => :environment do |t, args|
    Rake::Task["mokio:create_database"].execute
    Rake::Task["mokio:seed"].execute
    Rake::Task["mokio:install_routes"].execute
    Rake::Task["mokio:install_config"].execute
    Rake::Task["webpacker:install"].execute
    puts "Rake::Task mokio:install_default - Success".green
  end

  desc "Create database, running migrations and creating some default data for Mokio application"
  task :install, [:heroku,:email,:password] => :environment do |t, args|
    args.with_defaults(:email =>  @default_email, :password =>  @default_password,:heroku => false)
    @default_email = args[:email]
    @default_password = args[:password]

    if args[:heroku] == 'heroku'
      Rake::Task["mokio:install_heroku"].execute
    else
      Rake::Task["mokio:install_default"].execute
    end
    puts "Rake::Task mokio:install - Success".green
    puts "\nMokio is ready to start! Run 'rails server' and go to localhost:3000/backend to see your application in development mode"
  end

  namespace :menu do
    desc "Creates menu tree based on menu.yml file"
    task :create_final_tree => :environment do
      config = YAML.load_file("#{Rails.root}/config/menu.yml")

      langs = []

      config['langs'].each do |l|
        langs << Mokio::Lang.new(l)
      end

      Mokio::Lang.import langs

      menus = build_menu(config['menus'], nil)

      menus.each do |me|
        me.save(validate: false) #validation needs to be turned off as we create menu elements with editable flag set to false
      end
    end

    #recursively prepares Menu nodes based on given node list (menu_params)
    def build_menu(menu_params, ancestry)
      menus = []
      menu_params.each do |m|

        m["ancestry"] = ancestry
        new_menu = Mokio::Menu.new(m.except("children"))
        new_menu.build_meta
        menus << new_menu

        unless m["children"].nil?
          menus += build_menu(m["children"], ancestry.blank? ?  m['id'].to_s : ancestry + "/#{m['id'].to_s}")
        end
      end
      menus
    end
  end
end
