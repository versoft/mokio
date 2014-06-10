module Mokio
  class Engine < ::Rails::Engine
    #
    # Precompile hook
    #
    initializer "mokio.precompile", group: :all do |app|
      app.config.assets.precompile += %w( *.eot *.svg *.woff *.ttf
        html5.js
        backend.js
        backend.css
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
      )
    end
  end
end