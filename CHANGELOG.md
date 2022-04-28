#
# Mokio
# Ruby on Rails content management system
# Official premiere 11 June 2014


--------------------------------------------------------------------------------------------------------------

### Mokio (dev "Kolibroryfer") 25.04.2014 v0.0.1
<br/>

  1. Created gem with working application

    *~ Mokio was created as standard Rails application then moved to gem so it provides user-friendly usage*

  2. Added gem dependices to gemspec
    ~ Gem dependices are currently in progress

  3. Added configuration system working as Mokio's module variables

  4. Added generator for initializer file

  5. Specified TODO's for future updates

--------------------------------------------------------------------------------------------------------------

### Mokio (dev "Kolibroryfer") 7.05.2014 v0.0.2
<br/>

  1. Added users usage with Devise gem

    *~ We chose Devise gem for user auth, as its use is well known to Rails developers*

  2. Solved problems with "new" action in Menus

  3. Enabled Ckeditor assets

  4. Added solr_exceptions configuration key

  5. Disabled solr for default

  6. Created Mokio-install bash script

    *~ Script is installing Ruby and Rails using RVM, then installing application with mokio*

  7. Moved default uploader options to Mokio::Uploader::Asset module

  8. Fixed gem versions

  9. Fixed assets precompile hooks

  10. Added site helper on first login to cms

  11. Updated translations

    *~ Mokio for now provides only 'en' and 'pl' languages*

-------------------------------------------------------------------------------------------------------------

### Mokio (dev "Tree Pipit") 3.07.2014 v0.0.3
<br/>

  1. Updated mokio to support Rails 4.1.1

  2. Change Mokio to work as Rails engine

  3. Added modules to include in models and controllers with ActiveSupport::Concern

    *~ Every model or controller class can now be extened this way*

  4. Added some frontend helpers

    *~ Still in development*

  5. Added generators for copy assets and views

    *~ mokio:copy:assets, mokio:copy:views*

  6. Updated gems versions

  7. Changed views from Haml to Slim

    *~ This change was mosty caused our problems with rails fragment caching, in haml for some reason cached fragments disappeared.*
      *Slim rendering is also much faster than Haml.*

  8. Fully cached views.

    *~ see point 8.*

  9. Added some code documentation for rdoc generator

  10. Fixed precompiling ckeditor assets

  11. Fixed some bugs with breadcrumbs helper

  12. Fixed bug with "back to edit" url in flash notice for static modules

  13. Fixed bug with copy buttons

  14. Fixed some bugs with menu

  15. Fixed deleting last admin user

  16. Changed mokio:install rake to create default data in en (previously was in pl)

  17. Reworked helpers using haml_helpers to return html

    *~ Returning html should work with all views when haml helpers doesn't  *

  18. Added external scripts

  19. Added possibility for choosing menu in content new/edit views

  20. Cleaned up most of code

-------------------------------------------------------------------------------------------------------------

### Mokio (dev "Tree Pipit") 12.08.2014 v0.0.4
<br/>

  1. Added Mokio exceptions

    *~ Exception classes can be found under Mokio::Exceptions module*

    1.1 MokioError default exception

      *~ All below inherits from this*

    1.2 IsNotMenuRootError exception

    1.3 IsNotAMokioContentError exception

    1.4 IsNotAMokioMenuError exception

-------------------------------------------------------------------------------------------------------------

### Mokio 07.10.2014 v0.0.5
<br/>

  1. Add configurable mechanizm to extend standard Mokio views (check spec/dummy/config/views.yml)

  2. Easy way to add your own buttons in index views (main buttons and action buttons)

  3. Add languages management

  4. Add Mokio Logger

  5. More code cleanups

  6. Fixed handling solr configuration and content searching

  7. Show link to menu in form

  8. Fixed password update function

  9. Fixed "Your site" href

  10. Better generation of menu slug

  11. Add / change translations

  12. More flexible menu helpers

  13. More bug fixes

  14. More code cleanups

-------------------------------------------------------------------------------------------------------------

### Mokio 07.10.2014 v0.0.6
<br/>

  1. Update summary, description in mokio.gemspec

  2. Update changelog

-------------------------------------------------------------------------------------------------------------

### Mokio 28.10.2014  v0.0.7
<br/>

  1. Bugfix in ablility.rb

  2. Fix delete element confirmation

  3. Search box hidden when SOLR is off

  4. Bug fixes in ExternalScripts

  5. Prevent renderer from crash when can't find html element

  6. Add / change some translations

  7. Change "Users" to "Admins"

  8. Fixes in breadcrumbs and form for password change

  9. Add invalid password error message

  10. Clean up the mess in translations

  11. Reorganization of menu

  12. Added spaces between form actions buttons

  13. Add helper to create sidebar buttons (sidebar_btn)

  14. Add translation helper for sidebar buttons (bts)

  15. Rebuilding language management

  16. Improved movie gallery

  17. New README

  18. Version

  19. Smaller red header

  20. Removed option - whole window in menu creation

  21. Fix for backend search

  22. Change dual select box style in menu

  23. Fixed Mokio-install script

  24. New breadcrumbs

  25. Fixed user edit - no logout after password change

  26. Copy suffix

  26. Added posibility to translate datetimepicker

  27. Menu tree in content editor

  28. Copy suffix

  29. Hierarchical menu

  30. Minor menu fixes

  31. Generate slug for initial "top" menu

  32. Fix saving meta tags

  33. Install mokio migrations initializer

  34. Fix creating mokio.rb config file

  35. Delete meta and content_links after remove menu or lang

  36. Update static module lang_id after delete lang

  37. Ability to set static module language

  38. Change solr configuration for mokio models

  39. Order contents by title in dual_select_box (menu view)

  40. Show menu hierarchical slug in menu form

### Mokio 28.10.2014  v0.0.8

  1. Remove unnecessary migration

### Mokio 19.11.2014 v0.0.9

  1. Fix: disable caching in backend forms
  2. Menu with css helper bugfix
  3. Changes in translations
  4. Fix in search engine
  5. Fix assets problem in datepicker

### Mokio 16.12.2014  v0.0.10

  1. Add translations
  2. Add Slugged module (generate slug for any model that includes Mokio::Slugged)
  3. Fix saving "display from" and "display to" in content (english version)
  4. Added "displayed" scope for contents
  5. Added modules positions generator (usage: "rails g mokio:positions footer top left right")
  6. Build menu extended helper - with parameters
  7. Additional methods in menu (for slug)
  8. Copy menu - fix
  9. Content links removed when removing a content
  10. Generator for Google Analytics script (usage: "rails g mokio:ga_script UA-xxxxxxxx-xx)  - generates Mokio::ExternalScript object and partial view for frontend
  11. Added frontend helper: build_lang_menu

### Mokio 17.12.2014  v0.0.11

  1. Set 'simple_form' gem version to 3.0.2 (problems with 3.1.0)

### Mokio  09.02.2015 v0.0.12

  1. Fix in always_displayed static modules - removed from selected_modules
  2. New menu position - additional option
  3. Fix some update_active routes
  4. Menu helper option to generate localized links
  5. Changed helper for generating langs menu
  6. Added 'localized_slug' method to Slugged module
  7. Tests
  8. Fix for duplicates when creating Recipients

### Mokio 24.02.2015 v0.0.13
  1. Fix problem with cache in meta
  2. Fix problem with gallery uploader . gem jquery-fileupload-rails locked to version 0.4.1
  3. Add subtitle to article, pic_gallery, mov_gallery, contact page, menu and static module
  4. Add 'css_class' and 'css_body_class' fields to Mokio::Menu
  5. Add thumbnail to Mokio::Menu
  6. Password reset functionality

### Mokio 22.12.2015 v0.0.14
  1. Ckeditor attachment - added extensions for images
  2. Deleted old Device's views
  3. Add setting url host for Devise's mailer
  4. Simple mokio content generator for model and controller
  5. Fix "ActionController::RoutingError (No route matches [GET] "/backend/users/images/favicon.ico")" error
  6. Added first_name and last_name to Mokio::User
  7. Added created_by and updated_by for Mokio::Content
  8. Menu helper: possibility to add active menu elements ids
  9. Menu helper: option of displaying current menu and its contents (not menu children)
  10. Menu: better content/url switcher
  11. Menu: Extended parameters
  12. Menu helper: remove locale prefix if url is set
  13. Config file (mokio.rb) : Added ability to set where the user is to be redirected after logging in and logging out (based on model and role)
  14. Fix problem with cache in Movie Gallery
  15. Content main picture removing function
  16. GEMSPEC: Updating sass-rails to ~> 5.0
  17. Bugfix: display_from and display_to were cleaned after save PicGallery and MovGallery
  18. GEMSPEC: Updating ugliefier to ~> 2.7, DUMMY: lock mysql2 to 0.3.18, update gems
  19. CKEDITOR: Changed to 'Full' toolbar, translations based on I18n.locale; FORMS: Added intro field to Mokio::Contact form
### Mokio 06.04.2017 v0.0.15
  1. Update Rails to 5.0
  2. Possibility to add own models in main 'models' catalog and properly handling by common mokio controller
  3. Namespaced Ability
  4. Remove some deprecation warnings

### Mokio 01.10.2018 v0.1.0
<br/>
  1. Update Rails to 5.2.1
  2. Fix deprecated methods

### Mokio 05.10.2018 v0.1.1
<br/>
  1. Fix deprecated methods

### Mokio 06.12.2018 v0.1.2
<br/>
  1. Fix ckeditor issue with Rails 5.2

### Mokio 02.01.2019 v0.1.3
<br/>
  1. Explicit CMS language setting

### Mokio 12.08.2019 v0.1.4
<br/>
  1. Set Ckeditor version to ~>4.3
  2. Don't require language in Models::Content in belongs_to relation

### Mokio 14.10.2019 v0.1.5
<br/>
  1. Fix `redirect_to :back` to `redirect_to url`
  2. Add default sorting in datatable `def self.default_datatable_sorting`
  3. Override search columns when using datatable `def self.override_column_sort`

### Mokio 05.12.2019 v2.0.0
<br/>
  1. Upgrade to rails 6.0.1
  2. Removed old unused resources - base content
  3. Fix group_by for postgres database in fake menu

### Mokio 06.12.2019 v2.0.1
<br/>
  1. Migrations combined into one: add_mokio_to_application
  2. Fixed update active switch in backend datatable
  3. Added: pg sequence reset rake
  4. Updated: mokio install rake
  5. Changed default dummy app directory
  6. Added: webpacker gem to gemfile
  7. Updated: javascript precompile list

### Mokio 09.12.2019 v2.0.2
<br/>
  1. Updated: mokio_install rake
  2. Added: mokio_install_routes rake

### Mokio 10.12.2019 v2.0.3
<br/>
  1. Update datatable API

### Mokio 11.12.2019 v2.0.4
<br />
  1. 'Uniqueness validator will no longer enforce case sensitive comparison'
    Added: `case_sensitive: true` to :slug in
    - Mokio::Menu
    - Mokio::DataFile
  2. Updated: fake menu generation
  3. Fixed: Mokio::Menu belongs_to Mokio::Meta // optional: true

### Mokio 16.12.2019 v2.0.5
<br />
  1. Changed `protect_from_forgery with: :exception` to `protect_from_forgery prepend: true`
  2. Fixed admin password changing by add set_obj to prevent nil object exception
  3. Datatables fix acive button class

### Mokio 18.12.2019 v2.0.6
<br/>
  1. Added Mokio SeoTags
  2. Added: mokio_dynamic_fields
  3. Removed: mokio_meta && multilang form

### Mokio 20.12.2019 v2.0.7
<br />
  1. Changed: backend menu form from haml to slim
  2. Changed: dual select func in menu edit + controller
  3. Updated: Select2 js lib.
  4. Added: Select2 in backend forms
  5. Added: helpers in backend - form inputs
  6. Removed: Old backend haml views
  7. Added: theme custom css
  8. Removed: old select2 lib
  9. Added: select2 ajax data retrieve

### Mokio 08.01.2020 v2.0.8
<br/>
  1. Added: sitemap service and mokio config options
  2. Added: frontend initializer for set default_url_options // ENV['APP_HOST']

### Mokio 10.02.2020 v2.0.9
<br/>
  1. Fix import paths in backend.scss
  2. Fix multiple file upload by jquery-fileupload
  3. Replace `render nothing: true` to `render body: nil`

### Mokio 13.02.2020 v2.0.10
<br/>
  1. Remove gem jquery-fileupload-rails and add jquery libs instead

### Mokio 14.02.2020 v2.0.11
<br/>
  1. Change z-index to 1 in .heading
  2. Fix problem with upload photos in gallery - multiple params name

### Mokio 19.02.2020 v2.0.12
<br/>
  1. Add two ways for setup default SeoTags: `default_seo_tags` and `auto_create_meta_tags`.

## Mokio 20.02.2020 v2.0.13
<br/>
  1. Disable caching in admin panel
  2. Invalidate session cookie after logging out
  3. Increase password complexity requirement for Mokio::Users
  4. Add Devise :lockable to Mokio::Users

## Mokio 20.02.2020 v2.0.14
<br/>
  1. Add Devise :timeoutable to Mokio::Users

## Mokio 02.03.2020 v2.1.0
<br/>
  1. Add super admin role
  2. Confirm delete user using password
  3. Add `rake mokio:change_user_to_super_admin['email@sample.com']`

## Mokio 05.03.2020 v2.1.1
<br/>
  1. Add missing assets to mokio:precompile

## Mokio 05.03.2020 v2.1.2
<br/>
  1. Remove unused files
  2. Remove password reminder link (since it doesn't work)
  3. Cleanup routing

## Mokio 06.03.2020 v2.1.3
<br/>
  1. Add custom.js file

## Mokio 08.03.2020 v2.1.4
<br/>
  1. Fix password reminder

## Mokio 09.03.2020 v2.2.0
<br/>
  1. Add Google reCAPTCHA v3 during log in

## Mokio 06.03.2020 v2.2.1
<br/>
  1. Refactor mokio:install rake

## Mokio 18.03.2020 v2.3.0
<br/>
  1. Refactor galleries, so they can be used in custom models
  2. Add cosmetic changes; new css and missing translations
  3. Fix bootstrapSwitch is not a function bug
  4. Fix external photos uploading
  5. Change uploaded photos to be active by default

## Mokio 20.03.2020 v2.4.0
<br/>
  1. Add model history tracking

## Mokio 25.03.2020 v2.4.1
<br/>
  1. Fix RSpec tests
  2. Update Spec Dummy App
  3. Dont allow remove object when deletable: false
  4. Change Mokio::Menu lang to optional

## Mokio 26.03.2020 v2.4.2
<br/>
  1. Add CircleCI config
  2. Update Spec Dummy App database.yml file to works with .env config

## Mokio 26.03.2020 v2.5.0
<br/>
  1. Refactor Mokio::Users data editing

## Mokio 26.03.2020 v2.6.0
<br/>
  1. Move content in common form to separate tabs

## Mokio 26.03.2020 v2.7.0
<br/>

  1. Added backend search model feature
  2. Changed obj_class and obj_id flow in datatable.js.coffee for update_active
  3. Removed obj_class and obj_table from common index
  4. Added support for redirect back after destroy record in backend search
  5. Added datatable option for turn off search input ( default false )
  6. Added dedicated datatable module for backend search
  7. Moved active button code from common model to backend helper
  8. Added translations for additional columns in backend search
  9. Added default search input value based on query parameter
  10. Added content types in mokio settings (default)
  11. Removed base contents routing

## Mokio 03.04.2020 v2.7.1
<br/>
  1. Remove excessive Mokio::SiteHelper cookies

## Mokio 10.04.2020 v2.7.2
<br/>
  1. Fix tabbed form headers

## Mokio 10.04.2020 v2.7.3
<br/>
  1. Fix etag update

## Mokio 09.04.2020 v2.7.4
<br/>
  1. Fix gallery upload

## Mokio 13.05.2020 v2.7.5
<br/>
  1. Add basic filters in index views through config method "filter_index_config".

## Mokio 13.05.2020 v2.7.6
<br/>
  1. Add action button column hiding method in index view for each model
  2. Remove target=_"blank" from logo

## Mokio 12.08.2020 v2.7.7
<br/>
  1. Update method render_seo_meta_tags to accept array

## Mokio 13.08.2020 v2.7.8
<br/>
  1. Add Mokio::Sluglize and use it in Mokio::Content
  2. Fix saving recipients in contact pages

## Mokio 14.08.2020 v2.7.9
<br/>
  1. Add creating slug in contents_factory.rb

## Mokio 14.08.2020 v2.7.10
<br/>
  1. Add :custom_settings_defaults in settings

## Mokio 31.08.2020 v2.7.11
<br/>
  1. Change Devise timeout to 2h
  2. Fix Mokio::SiteHelper rendering

## Mokio 31.08.2020 v2.7.12
<br/>
  1. Fix CKEditor photo upload

## Mokio 31.08.2020 v2.7.13
<br/>
  1. Add missing time formats

## Mokio 04.09.2020 v2.7.14
<br/>
  1. Move Ckeditor mount from Gemfile to mokio:install

## Mokio 07.09.2020 v2.7.15
<br/>
  1. Add change author to histories

## Mokio 09.09.2020 v2.7.16
<br/>
  1. Add slug generator to Mokio::Articles and Mokio::PicGalleries

## Mokio 28.09.2020 v2.8.0
<br/>
  1. Add Static Pages feature
  2. Change default admin email
  3. Add label with prefix for slug field

## Mokio 13.08.2021 v2.9.0
<br/>
  1. Add frontend content editor
  2. Fix translation bug in Menu index
  3. Change redirect after save/create to the edit view not index
  4. Add preview frontend link and method 'mokio_preview_link_in_edit_page'

## Mokio 21.09.2021 v2.9.1
<br/>
  1. Add attr :disable_sitemap_generator and SitemapExternalLogic to sitemap generator service

## Mokio 14.10.2021 v2.9.2
<br/>
  1. Add missing js file to asset pipeline

## Mokio 18.10.2021 v2.9.3
<br/>
  1. Add task 'rake mokio:refresh_static_pages'
  2. Add optional 'default_value' for selects filters

## Mokio 23.11.2021 v2.9.4
<br/>
  1. Fix passing current_user to service StaticPageService

## Mokio 28.01.2022 v2.10.0
<br/>
  1. Add optional support for CKEditor5:
    - added configs in mokio.rb: `cke_root_images_path`, `use_ckeditor5`
    - helper for render CKEditor5 and CKEditor4 `render_ckeditor_field`
  2. Overwrite app/assets/stylesheets/ckeditor/skins/moono-lisa/editor.css and remove !important from icons background
  (on rails 6 icons started load with /icons.png instead of icons.png)

## Mokio 23.01.2021 v2.10.1
<br />
  1. Remove method 'render_additional_index_buttons'
  2. Add optional partials: '_index_buttons.html.slim', '_index_desc.html.slim' in index view

## Mokio 17.02.2022 v2.11.0
<br/>
  1. Move gem mokio_custom_settings inside Mokio as ApplicationSetting
  2. Add service `Mokio::Services::FindAppSetting`
  3. Restore method `render_additional_index_buttons` for compatibility with gems

## Mokio 28.04.2022 v2.11.1
1. Update sitemap docs
2. Add `rake mokio:recreate_sitemap` to recreate sitemap.xml
3. Minor fixes in SitemapService
