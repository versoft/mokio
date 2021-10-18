require 'rake'

namespace :mokio do
  desc 'Refresh static pages records basic on routing'

  task refresh_static_pages: :environment do
    puts 'Starting...'
    Mokio::Services::StaticPageService.new(disable_sitemap_regenerate: true).call
    puts 'Done.'
  end

end
