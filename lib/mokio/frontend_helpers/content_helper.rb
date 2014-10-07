module Mokio
  module FrontendHelpers
    #
    # Frontend helper methods contently used with Mokio models objects
    #
    module ContentHelper
      #
      # Raises IsNotAMokioContentError if obj isn't a Mokio::Content object
      #
      # ==== Attributes
      #
      # * +obj+ - any object
      #
      def isContent?(obj)
        raise Exceptions::IsNotAMokioContentError.new(obj) unless obj.is_a?(Mokio::Content)
      end

      #
      # Returns title field for given object
      #
      # ==== Attributes
      #
      # * +obj+ - Mokio::Content object (including inherited Mokio::Article etc..)
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioContentError+ when obj is not a  Mokio::Content object
      #
      def content_title(obj)
        isContent?(obj)
        obj.title
      end


      #
      # Returns intro field for given object as html
      #
      # ==== Attributes
      #
      # * +obj+ - Mokio::Content object (including inherited Mokio::Article etc..)
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioContentError+ when obj is not a  Mokio::Content object
      #
      def content_intro(obj)
        isContent?(obj)
        obj.intro.html_safe
      end

      #
      # Returns content field for given object as html
      #
      # ==== Attributes
      #
      # * +obj+ - Mokio::Content object (including inherited Mokio::Article etc..)
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioContentError+ when obj is not a  Mokio::Content object
      #
      def content_content(obj)
        isContent?(obj)
        obj.content.html_safe
      end


      #
      # Returns main picture for given object as html
      #
      # ==== Attributes
      #
      # * +obj+ - Mokio::Content object (including inherited Mokio::Article etc..)
      # * +version+ - Version of picture
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioContentError+ when obj is not a  Mokio::Content object
      #
      def content_main_pic(obj, version = nil)
        isContent?(obj)
        html = "<img src='#{obj.main_pic.url}'></img>".html_safe unless version
        html ||= "<img src='#{obj.main_pic.url(version.to_sym)}'></img>"
        html.html_safe
      end

      #
      # Returns main picture url for given object as string
      #
      # ==== Attributes
      #
      # * +obj+ - Mokio::Content object (including inherited Mokio::Article etc..)
      # * +version+ - Version of picture
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioContentError+ when obj is not a  Mokio::Content object
      #
      def main_pic_url(obj, version = nil)
        isContent?(obj)
        url = obj.main_pic.url unless version
        url ||= obj.main_pic.url(version.to_sym)
        url
      end
    end
  end
end