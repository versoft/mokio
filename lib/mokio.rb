require 'jquery-rails'
require 'jquery-ui-rails'
require 'haml-rails'
require 'simple_form'
require "ckeditor"
require "bootstrap-wysihtml5-rails"
require "carrierwave"
require 'amoeba'
require 'fancybox2-rails'
require "bootstrap-switch-rails"
require 'ancestry'
require 'acts_as_list'
require 'jquery-datatables-rails'
require 'will_paginate'
require 'sunspot_rails'
require 'faraday'
require 'validates'
require 'friendly_id'
require 'video_info'
require 'disqus'
require 'cancancan'
require 'role_model'
require 'sass-rails'
require 'slim'

#
# Mokio - Open Source CMS
#
module Mokio

  #
  # Constants
  #

  #
  # Rails version supported by Mokio
  #
  SUPPORTED_RAILS = 6

  #
  # Array of content types
  #
  CONTENT_TYPES   = ["Mokio::Article", "Mokio::Contact", "Mokio::PicGallery", "Mokio::MovGallery"]
  BASE_CONTENT_TYPES   = ["Mokio::BaseArticle", "Mokio::BaseContact", "Mokio::BasePicGallery", "Mokio::BaseMovGallery"]

  #
  # Default lang for backend
  #
  mattr_accessor :backend_default_lang
  self.backend_default_lang = "pl"

  #
  # TODO: is it necessary?
  # Default lang id for backend
  #
  mattr_accessor :backend_default_lang_id
  self.backend_default_lang_id = 1

  #
  # TODO: is it necessary?
  # Editable html in ckeditor on field 'intro'
  #
  mattr_accessor :enable_html_edit_intro
  self.enable_html_edit_intro = true

  #
  # TODO: is it necessary?
  # Editable html in ckeditor on field 'content'
  #
  mattr_accessor :enable_html_edit_content
  self.enable_html_edit_content = true

  #
  # TODO: is it necessary?
  # Enable edit menu
  #
  mattr_accessor :menu_editable
  self.menu_editable = true

  #
  # How many records are displayed per page
  #
  mattr_accessor :backend_default_per_page
  self.backend_default_per_page = 10

  #
  # TODO: Two below probably deprecated because of inluding users in 'standard' Mokio application
  #
    #
    # Backend login for basic authentication
    #
    mattr_accessor :backend_login
    self.backend_login = "admin"

    #
    # Backend password for basic authentication
    #
    mattr_accessor :backend_password
    self.backend_password = "admin"
  #

  #
  # Enable adding google maps for listed content types
  #
  mattr_accessor :backend_gmap_enabled
  self.backend_gmap_enabled = ["Mokio::Contact"]

  #
  # Language CMS
  #
  mattr_accessor :cms_locale
  self.cms_locale = :pl

  #
  # How much records are listed in dashboard boxes
  #
  mattr_accessor :dashboard_size
  self.dashboard_size = 5

  #
  # Default photo width for whole application (in px)
  #
  mattr_accessor :default_width
  self.default_width = 500

  #
  # Default photo height for whole application (in px)
  #
  mattr_accessor :default_height
  self.default_height = 500

  #
  # Width for photos thumb (in px)
  #
  mattr_accessor :photo_thumb_width
  self.photo_thumb_width = 100

  #
  # Height for photos thumb (in px)
  #
  mattr_accessor :photo_thumb_height
  self.photo_thumb_height = 100

  #
  # Medium width for scaling photos (in px)
  #
  mattr_accessor :photo_medium_width
  self.photo_medium_width = 400

  #
  # Medium height for scaling photos (in px)
  #
  mattr_accessor :photo_medium_height
  self.photo_medium_height = 400

  #
  # Big width for scaling photos (in px)
  #
  mattr_accessor :photo_big_width
  self.photo_big_width = 1000

  #
  # Big height for scaling photos (in px)
  #
  mattr_accessor :photo_big_height
  self.photo_big_height = 1000

  #
  # Enable placing watermarks on photos
  #
  mattr_accessor :enable_watermark
  mattr_accessor :watermark_path
  self.enable_watermark = false
  self.watermark_path = ""

  #
  # Default quality for youtube movies
  #
  mattr_accessor :youtube_movie_quality
  self.youtube_movie_quality = "medium"

  #
  # Default lang for frontend
  #
  mattr_accessor :frontend_default_lang
  self.frontend_default_lang = "en"

  #
  # TODO: is it necessary?
  #
  # in-development description:
  # id main menu element for specific language
  # only defined are available in application
  #
  mattr_accessor :frontend_initial_pl
  self.frontend_initial_pl = 1

  #
  # Facebook app id to use in frontend
  #
  mattr_accessor :frontend_facebook_app_id
  self.frontend_facebook_app_id = ''

  #
  # For developers, enable/disable debuging
  # use it for testing purposes
  #
  mattr_accessor :debug_all
  self.debug_all = false

  #
  # Enable/disale showing site helper in mokio
  #
  mattr_accessor :enable_site_helper
  self.enable_site_helper = true

  mattr_accessor :solr_enabled
  self.solr_enabled = false

  mattr_accessor :mokio_log_level
  self.mokio_log_level = Logger::DEBUG

  mattr_accessor :mokio_gems_parameters
  self.mokio_gems_parameters = {}

  mattr_accessor :after_sign_in_path
  self.after_sign_in_path = {:user => {}}

  mattr_accessor :after_sign_out_path
  self.after_sign_out_path = {:user => {}}

  # Enable/disable sitemap generation
  # include Mokio::Concerns::Common::Services::Sitemap::Model
  mattr_accessor :mokio_sitemap_generator_enable
  self.mokio_sitemap_generator_enable = false

  ### Google reCAPTCHA configs ###
  mattr_accessor :mokio_login_with_recaptcha
  self.mokio_login_with_recaptcha = false

  mattr_accessor :mokio_login_recaptcha_site_key
  self.mokio_login_recaptcha_site_key = ''

  mattr_accessor :mokio_login_recaptcha_secret_key
  self.mokio_login_recaptcha_secret_key = ''

  mattr_accessor :mokio_login_recaptcha_score
  self.mokio_login_recaptcha_score = 0.9

  # List of static routes it should be included in sitemap
  # -------------------------------------------------
  # loc: url  (required)
  # lastmod: last modification date ( can be nil )
  # priority: ( can be nil ) ( default 1.0 )
  # -------------------------
  # example  self.mokio_sitemap_generator_static =
  # [{loc: "www.exmaple.loc",lastmod: "YYYY-MM-DD HH-MM-SS+0000",priority: "1.0"}]
  # -------------------------------------------------

  mattr_accessor :mokio_sitemap_generator_static
  self.mokio_sitemap_generator_static = []

  # sitemap.xml path ( filename or subfolder path)
  # example: www.example.loc/location/sitemap_custom.xml
  # self.mokio_sitemap_generator_path = "location/sitemap_custom"

  mattr_accessor :mokio_sitemap_generator_path
  self.mokio_sitemap_generator_path = ""

  # Enabled models list
  # self.mokio_sitemap_enabled_models = ["Mokio::Content"]
  mattr_accessor :mokio_sitemap_enabled_models
  self.mokio_sitemap_enabled_models = ["Mokio::Content"]

  # Default time to log out unactive user
  mattr_accessor :devise_timeout_after
  self.devise_timeout_after = 15.minutes

  #
  # Default way to configure Mokio
  #
  # To overwite configs create initializer in application
  #
  # ==== Examples
  #
  #   Mokio.setup do |config|
  #     config.frontend_default_lang = "en"
  #   end
  #
  def self.setup
    yield self
  end
end

require 'devise'
require "mokio/core_extension"
require "mokio/engine"
require "mokio/exceptions"
require "mokio/simple-form-wrappers"
require "mokio/uploader"
require "mokio/solr_config"
require "mokio/site_helper"
require "mokio/concerns"
require "mokio/frontend_helpers"
require "mokio/logger"
require "mokio/template_renderer"
require "mokio/slugged"
require "mokio/version"
require "mokio/custom_gallery"
