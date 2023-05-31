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
  s.add_dependency 'rake'
  s.add_dependency 'rails',                       '~> 7.0.1'  #-----OLD: '~> 5.2.1'
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'haml-rails'
  s.add_dependency 'fancybox2-rails'
  s.add_dependency 'sunspot_rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-datatables-rails'
  s.add_dependency 'uglifier'
  s.add_dependency 'cancancan'
  s.add_dependency 'simple_form'
  s.add_dependency 'ckeditor',                    '~> 4.3'
  s.add_dependency 'carrierwave'
  s.add_dependency 'rmagick'
  s.add_dependency 'mini_magick'
  s.add_dependency 'amoeba'
  s.add_dependency 'ancestry'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'will_paginate'
  s.add_dependency 'friendly_id'
  s.add_dependency 'devise'
  s.add_dependency 'slim-rails'
  # ============================================================================
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'capybara'
  # ============================================================================
  # youtubeit dependency - no compatible with rails 6.0.1
  #s.add_dependency 'youtube_it',                  '~> 2.4.3'#,   '>= 2.4.3'  #-----OLD:  '~> 2.4',   '>= 2.4.3'
  #s.add_dependency 'faraday',                     '~> 0.9',   '>= 0.7.6'  #-----OLD:  '~> 0.9',   '>= 0.7.6'
  # video gallery dependency
  s.add_dependency 'video_info'

  # NOT UPDATED
  s.add_dependency 'bootstrap-wysihtml5-rails'
  s.add_dependency 'bootstrap-switch-rails'
  # NOT UPDATED - END

  # REMOVE?
  s.add_dependency 'validates'
  s.add_dependency 'deface'
  # not used
  s.add_dependency 'disqus'
  # REMOVE END

  # SHOULDE BE CHANGED?

  s.add_dependency 'role_model'

  # SHOULDE BE CHANGED END

  # ============================================================================
  #------------------------------- RAILS 6 DEPENDENCY WORK IN PROGRESS --------------------
  # factorybot
  # s.add_development_dependency 'factory_bot', '~> 5.1.1'


# TODO END
end

