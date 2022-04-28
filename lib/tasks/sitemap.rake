require 'rake'

namespace :mokio do
  desc 'Recreate sitemap.xml'

  task recreate_sitemap: :environment do
    puts 'Starting...'
    Mokio::Concerns::Common::Services::Sitemap::Service.regenerate_sitemap
    puts 'Done.'
  end

end
