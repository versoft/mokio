# CHANGELOG
- `bundle update rails`
- `rails app:update`
- - `bin/rails overrided`
- `files compared with clear engine`
- changed `SUPPORTED_RAILS = 5` to `SUPPORTED_RAILS = 6`

- changed in spec/dummy/config/application.rb
- - `require File.expand_path('../boot', __FILE__)` to `require_relative 'boot'`
- - added `config.load_defaults 6.0`

- changed in spec/dummy/config/environment.rb
- - `require File.expand_path('../application', __FILE__)` to `require_relative 'application'`

- changed in spec/dummy/app/controllers/application_controller.rb
- - `protect_from_forgery with: :exception` to  `protect_from_forgery prepend: true, with: :exception`

- changed in lib/mokio.rb
- - `require 'sass'` to: `require 'sass-rails'`
- - - CSS IN THEME NEED CHANGES `SASSC::SyntaxError`

- changed in lib/mokio/engine.rb
- - removed `initializer 'mokio.helpers'` cause `Initialization autoloaded the constants`

    initializer 'mokio.helpers' do |app|
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, Mokio::Backend::BackendHelper
        ActionView::Base.send :include, Mokio::Backend::BreadcrumbsHelper
        ActionView::Base.send :include, Mokio::Backend::CommonHelper
        ActionView::Base.send :include, Mokio::Backend::JavascriptHelper
        ActionView::Base.send :include, Mokio::Backend::MenuHelper
        ActionView::Base.send :include, Mokio::Backend::UrlHelper

        ActionView::Base.send :include, Mokio::FrontendHelpers::MenuHelper
        ActionView::Base.send :include, Mokio::FrontendHelpers::StaticModulesHelper
        ActionView::Base.send :include, Mokio::FrontendHelpers::ContentHelper
        ActionView::Base.send :include, Mokio::FrontendHelpers::ExternalScriptsHelper
        ActionView::Base.send :include, Mokio::FrontendHelpers::LangsHelper
      end
    end
- -

- added manifest file in spec/dummy/app/assets/config
- mokio install rake updated: added `Rake::Task["webpacker:install"].execute`
- jquery datatables scss changed to css ( sass error)
- added assets to engine.rb - compile errors
- changed datatables param: params[:sSearch] to params[:search][:value]
- changed data source in datatable.js.coffee.erb
- static_module `include_field` changed to `include_association` - deprecation

# removed form gemfile:
- `gem "factory_girl_rails" REMOVED FROM GEMFILE`
- `gem "rails_stdout_logging" ` cause: `Including LoggerSilence is deprecated and will be removed in Rails 6.1. Please use 'ActiveSupport::LoggerSilence' instead `

  To check: bin/rails zeitwerk:check

# added to gemfile
- `gem "factory_bot"`

# added to gemspec
- `if s.respond_to?(:metadata) `
- `s.add_dependency 'rack-proxy',                   '~> 0.6.5'`
- `s.add_dependency 'webpacker',                   '~> 4.2.0'`
- `s.add_development_dependency 'factory_bot', '~> 5.1.1'`


# removed files
- - remove base - class in model and controller NOT USED


