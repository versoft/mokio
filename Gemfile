source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in mokio.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'


#==================================================================================================
gem 'mysql2', '0.4.4' # this is NOT required, someone may want to use different database

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem "faker"
  # gem "capybara"
  # gem "capybara-webkit" # may be useful: apt-get install qtquick1-5-dev qtlocation5-dev qtsensors5-dev qtdeclarative5-dev

  #
  # or #sudo apt-get install qt4-dev-tools libqt4-dev libqt4-core libqt4-gui
  #
  gem "selenium-webdriver"
  gem 'simplecov'
  gem 'activerecord-import'

  # PROBLEM WITH DEPENDENCY RAKE 13.0.1
  # gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git' # Annotate ActiveRecord models as a gem
  #gem 'quiet_assets' #turns off the Rails asset pipeline log
  gem 'rack-mini-profiler' # displays speed badge for every html page
  #gem 'sunspot_solr' # optional pre-packaged Solr distribution for use in development
  gem 'progress_bar' # optional - for solr

  # Debuger:
    gem 'pry'
    gem 'pry-remote'
    gem 'pry-nav'

  # Better errors
    gem 'better_errors'
    gem 'binding_of_caller'
    gem 'meta_request' # To use rails_panel extension
    gem 'deface'
end

gem 'haml2slim'

# assety sie nie wczytywaly
gem 'rails_serve_static_assets'
# gem 'rails_stdout_logging'
# NOT FOUND DEPENDENCY FOR THIS GEM IN RAILS 6
# gem 'youtube_it', github: 'LiveWorld/youtube_it'
gem 'ckeditor', '~> 4.3'

# RAILS 6
group :development, :test do
  gem 'factory_bot'
end
