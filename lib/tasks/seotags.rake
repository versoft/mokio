namespace :seotags do
  task generate_from_meta: :environment do
    puts "Running this task will delete everything from mokio_seotags table.
    To continue press [Y].".red
    input = STDIN.gets.strip
    if input == 'Y'
      Rake::Task["seotags:generate_from_meta_continue"].reenable
      Rake::Task["seotags:generate_from_meta_continue"].invoke
    end
  end

  desc "Generate Mokio::Seotags from Mokio::Meta"
  task generate_from_meta_continue: :environment do
    puts "Emptying mokio_seotags table...".blue
    Mokio::SeoTag.delete_all

    class Mokio::Meta < ActiveRecord::Base; end
    contents = Mokio::Content.all
    menus = Mokio::Menu.all
    objs_to_generate_meta = contents + menus
    objs_to_generate_meta_count = objs_to_generate_meta.count
    meta_tag_map = {
      'g_title' => 'title',
      'g_desc' => 'description',
      'g_keywords' => 'keywords',
      'g_author' => 'author',
      'g_copyright' => 'copyright',
      'g_application_name' => 'application-name',
      'f_title' => 'og:title',
      'f_type' => 'og:type',
      'f_image' => 'og:image',
      'f_url' => 'og:url',
      'f_desc' => 'og:description'
    }

    puts "Generating Mokio::Seotags...".blue
    objs_to_generate_meta.each_with_index do |c, i|
      meta = Mokio::Meta.where(id: c.meta_id)&.first
      next unless meta.present?

      seo_tagable_id = c.id
      seo_tagable_type = "Mokio::Content"
      seo_tagable_type = "Mokio::Menu" if c.is_a? Mokio::Menu

      meta_tag_map.each do |t|
        tag_key = t.last
        tag_value = meta.send(t.first)

        Mokio::SeoTag.create(seo_tagable_type: seo_tagable_type, 
                             seo_tagable_id: seo_tagable_id, 
                             tag_key: tag_key, 
                             tag_value: tag_value)
      end

      puts "#{i + 1}/#{objs_to_generate_meta_count}"
    end

    puts "Done!".green
  end
end