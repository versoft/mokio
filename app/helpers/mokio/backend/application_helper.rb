module Mokio
  module Backend
    module ApplicationHelper
      def show_index_table_actions(obj_class)
        true unless obj_class.try(:show_index_table_actions?) == false
      end
    end
  end
end
