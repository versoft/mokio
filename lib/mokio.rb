require 'jquery-rails'
require 'jquery-ui-rails'
require 'haml-rails'
require 'simple_form'
require "ckeditor"
require "bootstrap-wysihtml5-rails"
require "carrierwave"
require "jquery-fileupload-rails"
require 'amoeba'
require 'fancybox2-rails'
require "bootstrap-switch-rails"
require 'youtube_it'
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
require 'devise'
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
  SUPPORTED_RAILS = 4

  #
  # Array of content types
  #
  CONTENT_TYPES   = ["Mokio::Article", "Mokio::Contact", "Mokio::PicGallery", "Mokio::MovGallery"]



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
  # Enable adding meta tags for listed models
  #
  mattr_accessor :backend_meta_enabled
  self.backend_meta_enabled = ["Mokio::Menu"] + Mokio::CONTENT_TYPES

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

require "mokio/core_extension"
require "mokio/engine"
require "mokio/exceptions"
require "mokio/simple-form-wrappers"
require "mokio/uploader"
require "mokio/solr_config"
require "mokio/site_helper"
require "mokio/concerns"
require "mokio/frontend_helpers"
require "mokio/mokio_logger"
require "mokio/ext_template_renderer"
