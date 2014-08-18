module Mokio
  #
  # Module for tour guide in Mokio
  #
  module SiteHelper
    module T #:nodoc:
      def self.key(key)
        "site_helper.#{key}"
      end
    end

    mattr_accessor :config
    mattr_accessor :debug

    self.debug = false

    self.config = {
      "/backend" => {
        "1" => {
          "data-class"   => "sidenav",
          "data-text"    => T.key("next"),
          "data-options" => "tipLocation:right",

          :title => T.key("welcome_title"),
          :text  => T.key("welcome_text")
        },

        "2" => {
          "data-class"   => "dashboard_nav",
          "data-text"    => T.key("next"),
          "data-options" => "tipLocation:right",

          :title => T.key("dashboard_nav_title"),
          :text  => T.key("dashboard_nav_text")
        },

        "3" => {
          "data-class"   => "contentmanagment_nav",
          "data-text"    => T.key("next"),
          "data-options" => "tipLocation:right",

          :title => T.key("contentmanagment_nav_title"),
          :text  => T.key("contentmanagment_nav_text")
        },

        "4" => {
          "data-class"   => "content_nav",
          "data-text"    => T.key("next"),
          "data-options" => "tipLocation:right",

          :title => T.key("content_nav_title"),
          :text  => T.key("content_nav_text")
        },

        "5" => {
          "data-class"   => "menu_nav",
          "data-text"    => T.key("next"),
          "data-options" => "tipLocation:right",

          :title => T.key("menu_nav_title"),
          :text  => T.key("menu_nav_text")
        },

        "6" => {
          "data-class"   => "static_module_nav",
          "data-text"    => T.key("next"),
          "data-options" => "tipLocation:right",

          :title => T.key("static_module_nav_title"),
          :text  => T.key("static_module_nav_text")
        },

        "7" => {
          "data-class"   => "user_nav",
          "data-text"    => T.key("next"),
          "data-options" => "tipLocation:right",

          :title => T.key("user_nav_title"),
          :text  => T.key("user_nav_text")
        }        
      } # end /backend


      #
      # Below only for test purposes
      #

      # "/backend/contents" => {
      #   "1" => {
      #     "data-class"   => "sidenav",
      #     "data-text"    => T.key("next"),
      #     "data-options" => "tipLocation:right",

      #     :title => T.key("title"),
      #     :text  => T.key("text")
      #   },

      #   "2" => {
      #     "data-class"   => "dashboard_nav",
      #     "data-text"    => T.key("next"),
      #     "data-options" => "tipLocation:right",

      #     :title => T.key("title"),
      #     :text  => T.key("text")
      #   }        
      # }
    } # end config
    
    def self.steps_for_url(current_path) #:nodoc:
      self.config.each do |key, value|
        return self.config[key.to_s] if key == current_path
      end

      {}
    end

    #
    # Adds new_config to config variable
    #
    # ==== Attributes
    #
    # * +new_config+ - Hash of parameters to add
    #
    def self.add_config(new_config)
      self.config.merge!(new_config)
    end

    #
    # Some way to change this module variables
    #
    def self.setup
      yield self
    end
  end
end