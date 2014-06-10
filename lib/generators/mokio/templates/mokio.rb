#
# Mokio global configuration
#
# Use this hook to configure Mokio
#
Mokio.setup do |config|

  # Here you can change the behaviour of Mokio application

  # Default language shortname for backend. 
  # Set to the shortname of the Lang record with the ID specified in :backend_default_lang_id. 
  # If you wish to change it for example to english, you need to do the following:
  # 
  # 1. Create Lang for english (with shortname en - shortname needs to be unique)
  # 2. Set backend_default_lang to "en"
  #
  # mattr_accessor :backend_default_lang
  # config.backend_default_lang = "pl"

  #
  # How many records are displayed per page. 
  # Whenever there is a need to display a list of elements in a table (contents, static modules, users) this value 
  # is used for pagination. Change this is you wish to display more or less records pew page. 
  # Please be careful, performance may decrease after increasing this value.
  #
  # mattr_accessor :backend_default_per_page
  # config.backend_default_per_page = 10

  #
  # Enable adding google maps for listed content types. 
  # Mentioned content types will have option to choose location. This can be displayed in frontend using Google Maps API.
  #
  # mattr_accessor :backend_gmap_enabled
  # config.backend_gmap_enabled = ["Contact"]
 
  #
  # Enable adding meta tags for listed models.
  # For mentioned classes it will be possible to set META tags (Facebook and Google ones). 
  # By default it is set for menu and all connent types. Menu meta tags are more important than content meta tags if both are defined.
  #
  # mattr_accessor :backend_meta_enabled
  # config.backend_meta_enabled = ["Menu"] + Mokio::CONTENT_TYPES

  #
  # How much records are listed in dashboard boxes. 
  #
  # mattr_accessor :dashboard_size
  # config.dashboard_size = 5

  # ************************************************
  # Once a photo is uploaded, four copies of this photo are created - using below values for width and height. Photo is scaled to match these dimensions. 
  # 
  # Default photo width for whole application (in px). 
  # Uploaded photo will be scaled to have the following width. 
  # Photos will also be displayed with this width in the backend (when a photo in gallery is clicked - big view) and in frontend.
  # Please note that after you change it, you need to upload you photos again. 
  # Otherwise uploaded photo will have previous width, only view will be scaled accordingly, what may affect photo quality.
  #
  # mattr_accessor :default_width
  # config.default_width = 500

  #
  # Default photo height for whole application (in px).
  # Similar to default_width.
  #
  # mattr_accessor :default_height
  # config.default_height = 500

  #
  # Width for photos thumb (in px).
  # Photo thumb (either automatically scaled from original photo or manuallu changed to different image) will be scaled to have the following width. 
  # Photos will also be displayed with this width in the backend (when a list of photos is displayed, when the thumb is displayed) and in frontend.
  # Please note that after you change it, you need to upload your photos again. 
  # Otherwise uploaded photo thumb will have previous width, only view will be scaled accordingly, what may affect photo thumb quality.

  # mattr_accessor :photo_thumb_width
  # config.photo_thumb_width = 100

  #
  # Height for photos thumb (in px).
  # Similar to photo_thumb_with
  #
  # mattr_accessor :photo_thumb_height
  # config.photo_thumb_height = 100

  #
  # Other photo sizes - works similarly to :default_width and :default_height

  # Medium width for scaling photos (in px)
  #
  # mattr_accessor :photo_medium_width
  # config.photo_medium_width = 400

  #
  # Medium height for scaling photos (in px)
  #
  # mattr_accessor :photo_medium_height
  # config.photo_medium_height = 400

  #
  # Big width for scaling photos (in px)
  #
  # mattr_accessor :photo_big_width
  # config.photo_big_width = 1000

  #
  # Big height for scaling photos (in px)
  #
  # mattr_accessor :photo_big_height
  # config.photo_big_height = 1000
  # 
  #
  # Enable placing watermarks on photos.
  # Once set to true, all the images uploaded to the site will be marked with watermark located under :watermark_path
  
  # mattr_accessor :enable_watermark
  # mattr_accessor :watermark_path
  # config.enable_watermark = false
  # config.watermark_path = ""

  #
  # Default quality for youtube movies.
  # You can set it to low, medium or high. It is used when getting movies from Youtube, Dailymotion and Vimeo -
  # if only there are movies with given quality provided.
  # mattr_accessor :youtube_movie_quality
  # config.youtube_movie_quality = "medium"

  #
  # Default lang for frontend
  #
  # Set to the shortname of the default frontend language 
  # If you wish to change it for example to english, you need to do the following:
  # 
  # 1. Create Lang for english (with shortname en - shortname needs to be unique) - unless already created
  # 2. Set frontend_default_lang to "en"
  # 
  # 4. Create Initial menu structure for this language (unless already created)
  #    4a. Create Menu element for lang node: en (fake: true, parent: nil, lang_id - ID of the record from point 1)
  #    4b. Create Menu element for menu position: top (fake: true, parent - element from point 4a, lang_id - ID of the record from point 1 )
  #    4c. (Optional) Create Menu element for other position if you wish to have more that one menu on your site
  # 3. Add frontend_initial_en variable end set it to the ID of Menu record from point 4a.
  # In your frontend views use :frontend_initial_en when calling build_menu

  # mattr_accessor :frontend_default_lang
  # config.frontend_default_lang = "pl"

  # Id  of root menu element for specific language
  
  # mattr_accessor :frontend_initial_pl
  # config.frontend_initial_pl = 1

  #
  # Facebook app id to use in frontend. 
  # If you would like to have facebook comments enabled for your application 
  # you need to provide Facebook App ID - you can get it from https://developers.facebook.com/apps
  #
  # mattr_accessor :frontend_facebook_app_id
  # config.frontend_facebook_app_id = ''

end