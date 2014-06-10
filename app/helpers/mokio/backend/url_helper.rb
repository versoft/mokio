module Mokio
  module Backend
    module UrlHelper
      def index_url(class_name)
        "/backend/#{class_name.name.tableize}/"
      end

      def new_url(class_name)
        "/backend/#{class_name.name.tableize}/new"
      end

      def edit_url(class_name, obj)
        "/backend/#{class_name.name.tableize}/#{obj.id}/edit" 
      end

      def obj_url(class_name, obj)
        "/backend/#{class_name.name.tableize}/#{obj.id}"
      end

      def copy_url(class_name, obj)
        "/backend/#{class_name.name.tableize}/#{obj.id}/copy" 
      end
    end
  end
end