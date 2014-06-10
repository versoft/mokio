require 'rake'

namespace :mokio do
  desc "Create database, running migrations and creating some default data for Mokio application"

  task :install, [:email, :password] => :environment do |t, args|
    args.with_defaults(:email => "admin@admin.com", :password => "admin")
    Thread.new do
      %x{ rails g mokio:install }
    end

    Rake::Task["mokio_engine:install:migrations"].execute
    Rake::Task["db:create"].execute
    Rake::Task["db:migrate"].execute

    Lang.create!(:name => 'polski', :shortname => 'pl', :active => true, :menu_id => Mokio.frontend_initial_pl, :id => 1)
    puts "\n Created default lang 'polski'".green

    ModulePosition.create!(:name => 'pozycja1')
    puts "\n Created default module position 'pozycja1'".green
    user = User.new({
      email: args[:email],
      password: args[:password], 
      password_confirmation: args[:password],
      roles_mask: 1
    })
    puts "\n Created default user #{args[:email]} with password #{args[:password]}".red if user.save(:validate => false)

    pl_menu = Menu.new({
      name: "pl",
      seq: 1,
      deletable: false,
      editable: false,
      lang_id: 1,
      id: 1,
      content_editable: false,
      modules_editable: false,
      fake: true
    })
    pl_menu.build_meta
    puts "\n Created default initial menu 'pl'".green if pl_menu.save(:validate => false)
    
    top_menu = Menu.new({
      name: "top",
      seq: 1,
      deletable: false,
      editable: false,
      lang_id: 1,
      id: 2,
      content_editable: false,
      modules_editable: false,
      fake: true,
      parent: pl_menu
    })
    pl_menu.build_meta
    puts "\n Created default initial menu 'top'".green if top_menu.save(:validate => false)

    puts "\n Created initializer(configuration file) in config/initializers/mokio.rb".green
    puts "\n Mokio is ready to start! Run 'rails server' and go to localhost:3000/backend to see your application in development mode"
  end


  namespace :menu do
    desc "Creates menu tree based on menu.yml file"

    task :create_final_tree => :environment do
      config = YAML.load_file("#{Rails.root}/config/menu.yml")

      langs = []

      config['langs'].each do |l|
        langs << Lang.new(l)
      end

      Lang.import langs
      
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
        new_menu = Menu.new(m.except("children"))
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
