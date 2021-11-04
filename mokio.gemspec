$:.push File.expand_path("lib", __dir__)
# Maintain your gem's version:
require "mokio/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mokio"
  s.version     = Mokio::VERSION
  s.licenses    = ['AGPL-3.0']
  s.authors     = ["versoft"]
  s.email       = ["info@mokio.org"]
  s.homepage    = "http://www.mokio.org"
  s.summary     = <<-EOF
    Mokio is a Content Management System that allows creation of
    sophisticated websites. Provides administration panel for adding
    content to your site, desiging menu structure and managing any
    kind of element that you wish to include on your site.
  EOF
  s.description = <<-EOF
    Mokio is a Content Management System that allows creation of
    sophisticated websites. It consists maily of administration panel for your
    desired website.
    It provides the following types of content: Article (piece of text with
    pictures, lists, links, etc.), Picture Gallery (easily managed article with
    a number of photos - thumbs and edition provided), Movie Gallery
    (article with links to Dailymotion, Vimeo and Youtube movies - thumbs
    and edition provided), Contact Page with Google map and contact form.

    Apart from content it is possible to manage menu structure of your
    website for each language and defined position (part of the screen).

    If this is not enough for what you need, you can also include pieces of
    HTML code that should be shared by some (or all) subpages - called
    HTML Blocks. You can define on which part of the page, these blocks
    should be displayed.
    Mokio provides also administration panel for javascripts, languages
    and backend users.

    Beside Mokio itself, there are various gems dedicated for Mokio, that
    extends its core functionality.

    Visit: http://www.mokio.org
    Folow us on facebook: https://www.facebook.com/mokioCMS
  EOF

  if s.respond_to?(:metadata)
    s.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  s.files       = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc", "CHANGELOG"]
  s.test_files  = Dir["spec/**/*"]

  # ============================================================================
  s.add_dependency 'rake',                        '~> 13.0.1' #-----OLD: '~> 10.3','>= 10.3.1'
  s.add_dependency 'rails',                       '~> 6.0.1'  #-----OLD: '~> 5.2.1'
  s.add_dependency 'sass-rails',                  '~> 6.0.0'  #-----OLD: '~> 5.0.0'
  s.add_dependency 'coffee-rails',                '~> 5.0.0'  #-----OLD: '~> 4.0','>= 4.0.0'
  s.add_dependency 'haml-rails',                  '~> 2.0.1'  #-----OLD: '~> 1'
  s.add_dependency 'fancybox2-rails',             '~> 0.2.7'  #-----OLD: '~> 0.2.7'
  s.add_dependency 'sunspot_rails',               '~> 2.5.0'  #-----OLD: '~> 2.2','>= 2.1.0'
  s.add_dependency 'jquery-ui-rails',             '~> 4.2.1'  #-----NEW: '~> 6.0.1' PROBLEMS: cant find dependency in js
  s.add_dependency 'jquery-rails',                '~> 4.3.5'  #-----OLD: '~> 4.1'
  s.add_dependency 'jquery-datatables-rails',     '~> 3.4.0'  #-----OLD: '~> 1.12','>= 1.12.2'
  s.add_dependency 'uglifier',                    '~> 4.2.0'  #-----OLD: '~> 2.7','>= 1.3.0'
  s.add_dependency 'cancancan',                   '~> 3.0.1'  #-----OLD: '~> 1.7'
  s.add_dependency 'simple_form',                 '>= 5.0.1'  #-----OLD: '>= 3.4'
  s.add_dependency 'ckeditor',                    '~> 4.3.0'  #-----OLD: '~> 4.2'
  s.add_dependency 'carrierwave',                 '~> 2.2.2'  #-----OLD:  '~> 0.10',  '>= 0.10.0'
  s.add_dependency 'rmagick',                     '~> 4.0.0'  #-----OLD:  '~> 2.13',  '>= 2.13.2'
  s.add_dependency 'mini_magick',                 '~> 4.10.1'  #-----OLD:  '~> 3.7',   '>= 3.7.0'
  s.add_dependency 'amoeba',                      '~> 3.1.0'  #-----OLD:  '~> 3.0'
  s.add_dependency 'ancestry',                    '~> 3.0.7'  #-----OLD:  '~> 2.1',   '>= 2.1.0'
  s.add_dependency 'acts_as_list',                '~> 1.0.0'  #-----OLD:  '~> 0.4',   '>= 0.4.0'
  s.add_dependency 'will_paginate',               '~> 3.2.1'  #-----OLD:  '~> 3.0',   '>= 3.0.5'
  s.add_dependency 'friendly_id',                 '~> 5.3.0'  #-----OLD:  '~> 5.0',   '>= 5.0.3'
  s.add_dependency 'devise',                      '~> 4.7.1'  #-----OLD:  '~> 4.2'
  s.add_dependency 'slim-rails',                  '~> 3.2.0'  #-----OLD:  '~> 3.1'
  # ============================================================================
  s.add_development_dependency 'rspec',           '~> 3.9.0'  #-----OLD:  '~> 3.5'
  s.add_development_dependency 'capybara',        '~> 2.18.0' #-----OLD:  '~> 2.7',   '>= 2.2.1'
  # ============================================================================
  # youtubeit dependency - no compatible with rails 6.0.1
  #s.add_dependency 'youtube_it',                  '~> 2.4.3'#,   '>= 2.4.3'  #-----OLD:  '~> 2.4',   '>= 2.4.3'
  #s.add_dependency 'faraday',                     '~> 0.9',   '>= 0.7.6'  #-----OLD:  '~> 0.9',   '>= 0.7.6'
  # video gallery dependency
  s.add_dependency 'video_info',                  '~> 2.3',   '>= 2.3.1'  #-----OLD:  '~> 2.3',   '>= 2.3.1'

  # NOT UPDATED
  s.add_dependency 'bootstrap-wysihtml5-rails',   '~> 0.3',   '>= 0.3.1.23'
  s.add_dependency 'bootstrap-switch-rails',      '2.0.0'     # TODO problems with >2.0.0
  # NOT UPDATED - END

  # REMOVE?
  s.add_dependency 'validates',                   '~> 0.0',   '>= 0.0.8'  #-----OLD:  '~> 0.0',   '>= 0.0.8'
  s.add_dependency 'deface',                      '~> 1.0',   '>= 1.0.0'  #-----OLD:  '~> 1.0',   '>= 1.0.0'
  # not used
  s.add_dependency 'disqus',                      '~> 1.0',   '>= 1.0.4'  #-----OLD:  '~> 1.0',   '>= 1.0.4'
  # REMOVE END

  # SHOULDE BE CHANGED?

  s.add_dependency 'role_model',                  '~> 0.8.2'  #-----OLD:  '~> 0.8',   '>= 0.8.1'

  # SHOULDE BE CHANGED END

  # ============================================================================
  #------------------------------- RAILS 6 DEPENDENCY WORK IN PROGRESS --------------------
  # webpacker
  s.add_dependency 'rack-proxy',                   '~> 0.6.5'
  s.add_dependency 'webpacker',                   '~> 4.2.0'

  # factorybot
  s.add_development_dependency 'factory_bot', '~> 5.1.1'


# TODO END
end

