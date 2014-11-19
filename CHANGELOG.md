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
  
  1. Remove unnecessary migrations

### Mokio <add release date> v0.0.9
  1. Fix: disable caching in backend forms
  2. Menu with css helper bugfix
  3. Changes in translations