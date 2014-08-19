module Mokio
  #
  # Mokio::Engine < Rails::Engine
  #
  class Engine < Rails::Engine
    isolate_namespace Mokio

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
        ActionView::Base.send :include, Mokio::FrontendHelpers::TemplateHelper
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
      app.config.views_config = Mokio::FrontendHelpers::TemplateHelper.read_config
    end
  end
end