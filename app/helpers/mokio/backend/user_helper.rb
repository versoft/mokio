module Mokio
  module Backend
    module UserHelper
      def can_generate_pass_change_link?(obj)
        obj != current_user
      end

      def can_edit_password_without_confirmation?(obj)
        current_user.is_super_admin? && obj != current_user
      end

      def is_action_user_edit?
        params[:action] == "edit" && params[:controller] == "users"
      end
    end
  end
end
