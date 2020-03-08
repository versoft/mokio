namespace :mokio_install do
  desc 'Create default Mokio::Langs'
  task create_langs: :environment do
    unless Mokio::Lang.any? 
      default_lang_name = Mokio.frontend_default_lang
      default_lang = Mokio::Lang.new({
                                      name: default_lang_name,
                                      shortname: default_lang_name,
                                      active: true,
                                      menu_id: Mokio.frontend_initial_pl,
                                      id: 1
                                    })
      puts "Created default lang '#{default_lang.name}'".green if default_lang.save
    else
      puts 'Mokio::Langs already exist'.brown
    end
  end
end