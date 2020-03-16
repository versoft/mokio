module Mokio
  module Backend
    module UrlHelper
      def index_url(class_name)
        "#{engine_root}#{class_link(class_name)}/"
      end

      def new_url(class_name)
        "#{engine_root}#{class_link(class_name)}/new"
      end

      def edit_url(class_name, obj)
        "#{engine_root}#{class_link(class_name)}/#{obj.id}/edit"
      end

      def obj_url(class_name, obj)
        "#{engine_root}#{class_link(class_name)}/#{obj.id}"
      end

      def copy_url(class_name, obj)
        "#{engine_root}#{class_link(class_name)}/#{obj.id}/copy"
      end

      def class_link(class_name)
        class_name.name.tableize.gsub("mokio/", "")
      end
    end
  end
end
