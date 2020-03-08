namespace :mokio_install do
  desc 'Create default Mokio::Menus'
  task create_menus: :environment do
    unless Mokio::Menu.any? 
      # todo: find where menus are actually generated
      menu = Mokio::Menu.find_by_name(default_lang_name)
      puts "Created default initial menu '#{menu.name}'".green unless menu.nil?

      top_menu = Mokio::Menu.find_by_name('top')
      unless top_menu.present?
        top_menu = Mokio::Menu.new({
                                    name: 'top',
                                    seq: 1,
                                    deletable: false,
                                    editable: false,
                                    lang_id: 1,
                                    id: 2,
                                    content_editable: false,
                                    modules_editable: false,
                                    fake: true,
                                    parent: menu,
                                    slug: 'top'
                                  })
        puts "Created default initial menu 'top'".green if top_menu.save(validate: false)
      else
        puts "Mokio::Menu '#{top_menu.name}' already exists".brown
      end
    else
      puts 'Mokio::Menus already exist'.brown
    end
  end
end