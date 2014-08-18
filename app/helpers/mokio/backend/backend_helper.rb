module Mokio
  module Backend
    module BackendHelper  
      include Haml::Helpers
      #
      # Translate methods
      #
      def bt( title, from_modal_name = nil )
        t( from_modal_name.nil? ? "backend.#{title}" : "#{from_modal_name.to_s.tableize}.#{title}".gsub("mokio/", "") )
      end

      def btc( title, from_modal_name = nil )
        bt(title, from_modal_name).capitalize
      end

      def engine_root
        Mokio::Engine.routes.url_helpers.root_path
      end
    end
  end
end