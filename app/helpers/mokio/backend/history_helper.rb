module Mokio
  module Backend
    module HistoryHelper

      def history_helper_display(obj)
        (
          (obj.class.respond_to?('has_historable_displayed?') &&  obj.class.has_historable_displayed?) &&
          (obj.class.respond_to?('has_historable_enabled?') && obj.class.has_historable_enabled?) &&
          obj.history_collection.size > 0 &&
          !current_page?(action: 'new')
        )
      end

      def history_helper_show_more
        val = bt("show_more", Mokio::History)
        link_to val ,"#",class: "show_more"
      end

      def history_helper_header(val,obj)
        return nil if val.nil?
        value = ""
        value += val.to_datetime.strftime("%d-%m-%Y  - %H:%M:%S") rescue val

        if obj.first.user_email.present?
          value += " - #{obj.first.user_email}"
        end

        value
      end

      def history_helper_input(input_name,value)
        methodname = "history_mark_#{input_name}"
        return nil if value.nil?

        if self.respond_to?(methodname)
          return self.send(methodname,value)
        else
          return value
        end
      end

      def history_helper_label(obj)
        field = obj.field
        classname = obj.historable_type
        bt(field, classname)
      end

      def history_bool_mark_format(value)
        (value == "t") ? "ON" : "OFF"
      end

      def history_date_mark_format(value)
        value.to_datetime.strftime("%d-%m-%Y  - %H:%M") rescue value
      end

      def history_date_html_mark_format(value)
        value.html_safe
      end

      # INPUTS
      def history_mark_lang_id(value)
        Mokio::Lang.find(value).name rescue value
      end

      def history_mark_active(value)
        history_bool_mark_format(value)
      end

      def history_mark_home_page(value)
        history_bool_mark_format(value)
      end

      def history_mark_display_from(value)
        history_date_mark_format(value)
      end

      def history_mark_display_to(value)
        history_date_mark_format(value)
      end

      def history_mark_content(value)
        history_date_html_mark_format(value)
      end

      def history_mark_intro(value)
        history_date_html_mark_format(value)
      end
    end
  end
end
