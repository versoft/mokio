module Mokio
  module Backend
    module BackendHelper  

      #
      # Translate methods
      #
      def bt( title, from_modal_name = nil )
        t( from_modal_name.nil? ? "backend.#{title}" : "#{from_modal_name.to_s.tableize}.#{title}" )
      end

      def btc( title, from_modal_name = nil )
        bt(title, from_modal_name).capitalize
      end
    end
  end
end