module Mokio
  #
  # Mokio::Engine < Rails::Engine
  #
  class Engine < Rails::Engine
    isolate_namespace Mokio

    initializer :copy_migrations do |app|
      unless app.root.to_s.match root.to_s
        railties = {}
        railties["mokio"] = config.paths["db/migrate"].expanded.first

        on_skip = Proc.new do |name, migration|
          puts "NOTE: Migration #{migration.basename} from #{name} has been skipped. Migration with the same name already exists."
        end

        on_copy = Proc.new do |name, migration|
          puts "\nCopied migration #{migration.basename} from #{name}\n".green + "Run rake db:migrate first!\n".red
        end
        ActiveRecord::Migration.copy(ActiveRecord::Migrator.migrations_paths.first, railties,
                                     :on_skip => on_skip, :on_copy => on_copy)
      end
    end

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
        ActionView::Base.send :include, Mokio::FrontendHelpers::SeoTagHelper

      end
    end

    #
    # Precompile hook
    #
    initializer "mokio.precompile", group: :all do |app|
      app.config.assets.precompile += %w( *.eot *.svg *.woff *.ttf
        html5.js
        mokio.js
        backend.js
        backend.css
        images/*
        backend/*
        backend/**/*
        backend/patterns/1.png
        backend/patterns/2.png
        backend/patterns/3.png
        backend/patterns/4.png
        backend/patterns/5.png
        backend/patterns/3-1.png
        backend/search.png
        ckeditor/*
        ckeditor/**/*
        ckeditor/skins/moono/icons.png
        backend/loader.gif
        backend/search.png
        progressbar.gif
        loading.gif
        images/ui-bg_flat_75_ffffff_40x100.png
        ckeditor/contents.css
        backend/forms.js
        backend/gmap.js
        backend/jquery.ui.addresspicker.js
        frontend.js
        frontend.css
        frontend/*
        frontend/bg/*
        backend/head.js
      )
    end

    initializer "mokio.fonts", group: :all do |app|
      app.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    end

    initializer "mokio.views" do |app|
      app.config.views_config = Mokio::TemplateRenderer.read_config
    end

    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

  end
end